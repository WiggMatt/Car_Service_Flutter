import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/button_styles.dart';
import 'package:car_service/presentation/pages/alert_dialog/add_client_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlsOfClientsTable extends StatefulWidget {
  const ControlsOfClientsTable({Key? key}) : super(key: key);

  @override
  State<ControlsOfClientsTable> createState() => _ControlsOfClientsTableState();
}

class _ControlsOfClientsTableState extends State<ControlsOfClientsTable> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ClientBloc>(context);

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
              padding: const EdgeInsets.only(bottom: 40, left: 250),
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
                              return AddClientAlert(clientBloc: bloc);
                            });
                      },
                      child: const Text('Добавить запись')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        bloc.add(DeleteClientEvent());
                      },
                      child: const Text('Удалить запись')),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
