import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/button_styles.dart';
import 'package:car_service/presentation/pages/alert_dialog/add_mechanic_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ControlsOfMechanicsAndWorkTable extends StatefulWidget {
  const ControlsOfMechanicsAndWorkTable({Key? key}) : super(key: key);

  @override
  State<ControlsOfMechanicsAndWorkTable> createState() =>
      _ControlsOfMechanicsAndWorkTableState();
}

class _ControlsOfMechanicsAndWorkTableState
    extends State<ControlsOfMechanicsAndWorkTable> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MechanicsAndWorksBloc>(context);

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
                              return AddMechanicAlert(mechanicBloc: bloc)
                                ..mechanicBloc
                                    .add(FillWorkDescDropDownButtonEvent());
                            });
                      },
                      child: const Text('Добавить запись')),
                  const SizedBox(height: 20, width: 60),
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        var currentRow = loadedModels
                            .loadedMechanicsList[getCurrRow()].cells.values
                            .map((e) => e.value);

                        bloc.add(DeleteMechanicEvent(
                            firstName: currentRow.elementAt(0),
                            lastName: currentRow.elementAt(1),
                            workDesc: currentRow.elementAt(2)));
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
