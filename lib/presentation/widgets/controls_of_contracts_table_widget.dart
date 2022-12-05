import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/button_styles.dart';
import 'package:car_service/presentation/pages/alert_dialog/add_contract_alert.dart';
import 'package:car_service/presentation/pages/alert_dialog/edit_contract_alert.dart';
import 'package:car_service/presentation/pages/alert_dialog/search_contract_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlsOfContractsTable extends StatefulWidget {
  const ControlsOfContractsTable({Key? key}) : super(key: key);

  @override
  State<ControlsOfContractsTable> createState() =>
      _ControlsOfContractsTableState();
}

class _ControlsOfContractsTableState extends State<ControlsOfContractsTable> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ContractBloc>(context);

    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 100,
        ),
        //flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 300),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              bloc.add(FillAddEditAlertsEvent());
                              return AddContractAlert(contractBloc: bloc);
                            });
                      },
                      child: const Text('Добавить запись')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              bloc.add(GetCurrentRowEvent());

                              return EditContractAlert(contractBloc: bloc);
                            });
                      },
                      child: const Text('Изменить данные')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        bloc.add(DeleteContractEvent());
                      },
                      child: const Text('Удалить запись')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SearchContractAlert(contractBloc: bloc);
                            });
                      },
                      child: const Text('Поиск записи')),
                  const SizedBox(height: 20, width: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
