import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/button_styles.dart';
import 'package:car_service/presentation/pages/alert_dialog/add_contract_alert.dart';
import 'package:car_service/presentation/pages/alert_dialog/edit_contract_alert.dart';
import 'package:car_service/presentation/pages/alert_dialog/search_contract_alert.dart';
import 'package:car_service/presentation/pages/clients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlsOfTable extends StatefulWidget {
  const ControlsOfTable({Key? key}) : super(key: key);

  @override
  State<ControlsOfTable> createState() => _ControlsOfTableState();
}

class _ControlsOfTableState extends State<ControlsOfTable> {
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
              padding: const EdgeInsets.only(bottom: 40),
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
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScreenForClients(contractBloc: bloc)));
                      },
                      child: const Text('Таблица с клиентами')),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
