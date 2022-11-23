import 'package:flutter/material.dart';
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

  /// Text Column definition
  PlutoColumn(
    title: 'ID работника',
    field: 'worker_field',
    type: PlutoColumnType.number(),
  ),
];

class SearchedContractsTableScreen extends StatefulWidget {
  const SearchedContractsTableScreen({Key? key, required this.rows})
      : super(key: key);

  final List<PlutoRow> rows;

  @override
  State<SearchedContractsTableScreen> createState() =>
      _SearchedContractsTableScreenState();
}

class _SearchedContractsTableScreenState
    extends State<SearchedContractsTableScreen> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Результаты поиска'),
        ),
        body: PlutoGrid(
          mode: PlutoGridMode.readOnly,
          configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal),
          ),
          columns: columns,
          rows: [],
          onLoaded: (event) => {
            stateManager = event.stateManager,
            stateManager.removeAllRows(),
            stateManager.appendRows(widget.rows)
          },
        ));
  }
}
