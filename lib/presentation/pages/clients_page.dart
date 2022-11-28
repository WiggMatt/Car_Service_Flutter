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

class ScreenForClients extends StatefulWidget {
  const ScreenForClients({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<ScreenForClients> createState() => _ScreenForClientsState();
}

class _ScreenForClientsState extends State<ScreenForClients> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    widget.contractBloc.add(LoadingClientsTableEvent());
    late final PlutoGridStateManager stateManager;

    return BlocConsumer<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is ClientsInitialState) {
          stateManager.removeAllRows();
          stateManager.appendRows(models.loadedClientsList);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Клиенты'),
            ),
            body: PlutoGrid(
              configuration: const PlutoGridConfiguration(
                columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.equal),
              ),
              columns: clientsColumns,
              rows: [],
              onLoaded: (event) => stateManager = event.stateManager,
            ));
      },
    );
  }
}
