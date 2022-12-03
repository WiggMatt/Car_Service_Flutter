import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> mAwColumns = [
  /// Text Column definition
  PlutoColumn(
    title: 'Имя',
    field: 'name_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Фамилия',
    field: 'surname_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Описание работы',
    field: 'work_description_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Цена работы',
    field: 'work_coast_field',
    type: PlutoColumnType.text(),
  ),
];

class MechanicsAndWorksTable extends StatefulWidget {
  const MechanicsAndWorksTable({Key? key, required this.mechanicsAndWorksBloc})
      : super(key: key);

  final MechanicsAndWorksBloc mechanicsAndWorksBloc;

  @override
  State<MechanicsAndWorksTable> createState() => _MechanicsAndWorksTableState();
}

class _MechanicsAndWorksTableState extends State<MechanicsAndWorksTable> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MechanicsAndWorksBloc, MechanicsAndWorksState>(
      listener: (context, state) {
        if (state is MechanicsAndWorksInitialState) {
          stateManager.removeAllRows();
          stateManager.appendRows(loadedModels.loadedMechanicsList);
        }
      },
      builder: (context, state) {
        return PlutoGrid(
          mode: PlutoGridMode.selectWithOneTap,
          configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal),
          ),
          columns: mAwColumns,
          rows: [],
          onLoaded: (event) => stateManager = event.stateManager,
        );
      },
    );
  }
}
