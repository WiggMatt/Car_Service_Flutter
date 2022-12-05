part of 'client_bloc.dart';

@immutable
abstract class ClientEvent {}

class AddClientEvent extends ClientEvent {
  final String stsNum;
  final String carBrand;
  final String carModel;
  final String firstName;
  final String lastName;
  final String telephoneNum;

  AddClientEvent(
      {required this.stsNum,
      required this.carBrand,
      required this.carModel,
      required this.firstName,
      required this.lastName,
      required this.telephoneNum});
}

class DeleteClientEvent extends ClientEvent {}

class LoadingClientsTableEvent extends ClientEvent {}

class ChangedSelectedClientEvent extends ClientEvent {
  final int? selectedRow;

  ChangedSelectedClientEvent({required this.selectedRow});
}
