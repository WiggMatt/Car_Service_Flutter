import 'package:bloc/bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/repository/domain_repository_for_clients.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final DomainClientsRepository repository;

  ClientBloc({required this.repository})
      : super(ClientsInitialState(clientsRows: [])) {
    on<LoadingClientsTableEvent>(_loadingClientsTable);
    on<AddClientEvent>(_addClientEvent);
    on<DeleteClientEvent>(_deleteClientEvent);
    on<ChangedSelectedClientEvent>(_changeSelectedClientEvent);
  }

  _loadingClientsTable(
      LoadingClientsTableEvent event, Emitter<ClientState> emit) async {
    loadedModels = await repository.onStartLoadClientsRows();
    emit(ClientsInitialState(clientsRows: loadedModels.loadedClientsList));
  }

  _addClientEvent(AddClientEvent event, Emitter<ClientState> emit) async {
    await repository.onAddClient(event);
    add(LoadingClientsTableEvent());
  }

  _deleteClientEvent(DeleteClientEvent event, Emitter<ClientState> emit) async {
    List<int> clientData = await repository.onChangeSelectedRow(
        ChangedSelectedClientEvent(selectedRow: _selectedClientRow));
    await repository.onDeleteClient(clientData[0], clientData[1]);
    add(LoadingClientsTableEvent());
  }

  _changeSelectedClientEvent(
      ChangedSelectedClientEvent event, Emitter<ClientState> emit) {
    _selectedClientRow = event.selectedRow!;
  }
}
