part of 'client_bloc.dart';

@immutable
abstract class ClientState {}

class ClientsInitialState extends ClientState {
  final List<PlutoRow> clientsRows;

  ClientsInitialState({required this.clientsRows});
}
