import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
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
  }

  _loadingClientsTable(
      LoadingClientsTableEvent event, Emitter<ClientState> emit) async {
    loadedModels = await repository.onStartLoadClientsRows();
    emit(ClientsInitialState(clientsRows: loadedModels.loadedClientsList));
  }
}
