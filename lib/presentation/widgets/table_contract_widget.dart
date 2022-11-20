import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> columns = [
  /// Text Column definition
  PlutoColumn(
    title: 'Номер СТС',
    field: 'sts_field',
    type: PlutoColumnType.number(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Марка авто',
    field: 'brand_auto_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Модель авто',
    field: 'model_auto_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Код работы',
    field: 'work_field',
    type: PlutoColumnType.text(),
  ),

/*  /// Text Column definition
  PlutoColumn(
    title: 'Итоговая стоимость',
    field: 'coast_field',
    type: PlutoColumnType.number(),
  ),*/

  /// Text Column definition
  PlutoColumn(
    title: 'ID работника',
    field: 'worker_field',
    type: PlutoColumnType.number(),
  ),

/*  /// Text Column definition
  PlutoColumn(
    title: 'Дата обращения',
    field: 'date_of_application_field',
    type: PlutoColumnType.date(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Дата окончания',
    field: 'end_date_field',
    type: PlutoColumnType.date(),
  ),*/
];

class ContractsTable extends StatefulWidget {
  const ContractsTable({Key? key}) : super(key: key);

  @override
  State<ContractsTable> createState() => _ContractsTableState();
}

class _ContractsTableState extends State<ContractsTable> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is ContractInitialState) {
          stateManager.removeAllRows();
          stateManager.appendRows(state.contractsRows);
        }
      },
      builder: (context, state) {
        return PlutoGrid(
          mode: PlutoGridMode.selectWithOneTap,
          configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal),
          ),
          columns: columns,
          rows: [],
          onSelected: (PlutoGridOnSelectedEvent event) {
            final bloc = BlocProvider.of<ContractBloc>(context);
            bloc.add(ChangedSelectedContractEvent(selectedRow: event.rowIdx));
          },
          onLoaded: (event) => stateManager = event.stateManager,
        );
      },
    );
  }
}
