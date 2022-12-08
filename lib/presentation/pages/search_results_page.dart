import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> columns = [
  /// Text Column definition
  PlutoColumn(
    title: 'Номер СТС',
    field: 'sts_field',
    type: PlutoColumnType.text(),
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
    title: 'Наименование работы',
    field: 'work_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Фамилия работника',
    field: 'worker_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Стоимость работы',
    field: 'coast_field',
    type: PlutoColumnType.number(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Готовность',
    field: 'ready_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Оплата',
    field: 'payment_field',
    type: PlutoColumnType.text(),
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
          rows: widget.rows,
        ));
  }
}
