import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> clientsColumns = [
  /// Text Column definition
  PlutoColumn(
    title: 'Марка авто',
    field: 'brand_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Модель авто',
    field: 'model_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Номер СТС',
    field: 'sts_field',
    type: PlutoColumnType.text(),
  ),

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
    title: 'Номер телефона',
    field: 'telephone_field',
    type: PlutoColumnType.text(),
  ),
];

class ClientsTable extends StatefulWidget {
  const ClientsTable({Key? key, required this.clientBloc}) : super(key: key);

  final ClientBloc clientBloc;

  @override
  State<ClientsTable> createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state is ClientsInitialState) {
          stateManager.removeAllRows();
          stateManager.appendRows(loadedModels.loadedClientsList);
        }
      },
      builder: (context, state) {
        return PlutoGrid(
          mode: PlutoGridMode.selectWithOneTap,
          configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal),
          ),
          columns: clientsColumns,
          rows: [],
          onLoaded: (event) => stateManager = event.stateManager,
        );
      },
    );
  }
}
