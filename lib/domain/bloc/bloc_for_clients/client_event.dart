part of 'client_bloc.dart';

@immutable
abstract class ClientEvent {}

class AddClientEvent extends ClientEvent {}

class DelClientEvent extends ClientEvent {}

class LoadingClientsTableEvent extends ClientEvent {}
