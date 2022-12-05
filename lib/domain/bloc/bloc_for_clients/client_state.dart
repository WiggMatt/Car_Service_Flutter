part of 'client_bloc.dart';

@immutable
abstract class ClientState {}

int _selectedClientRow = -1;

class ClientsInitialState extends ClientState {
  final List<PlutoRow> clientsRows;

  ClientsInitialState({required this.clientsRows});
}

class ClientCurrentRowInitialState extends ContractState {
  final PlutoRow row;

  ClientCurrentRowInitialState({required this.row});
}
