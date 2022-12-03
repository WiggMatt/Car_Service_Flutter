import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/button_styles.dart';
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
                      onPressed: () {},
                      child: const Text('Добавить запись')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {},
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
