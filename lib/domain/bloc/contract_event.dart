part of 'contract_bloc.dart';

@immutable
abstract class ContractEvent {}

class AddContractEvent extends ContractEvent {
  final int stsNum;
  final String carBrand;
  final String carModel;
  final int workerID;
  final int workID;

  AddContractEvent(
      {required this.stsNum,
      required this.carBrand,
      required this.carModel,
      required this.workerID,
      required this.workID});
}

class DeleteContractEvent extends ContractEvent {}

class ChangedSelectedContractEvent extends ContractEvent {
  final int? selectedRow;
  ChangedSelectedContractEvent({required this.selectedRow});
}

class EditContractEvent extends ContractEvent {
  final int stsNum;
  final String carBrand;
  final String carModel;
  final int workerID;
  final int workID;

  EditContractEvent(
      {required this.stsNum,
      required this.carBrand,
      required this.carModel,
      required this.workerID,
      required this.workID});
}

class GetCurrentRowEvent extends ContractEvent {}

class SearchContractEvent extends ContractEvent {
  final int stsNum;
  final String carBrand;
  final String carModel;
  final int workerID;
  final int workID;

  SearchContractEvent(
      {required this.stsNum,
      required this.carBrand,
      required this.carModel,
      required this.workerID,
      required this.workID});
}

class SearchAlertEvent extends ContractEvent {
  final String stsNum;

  SearchAlertEvent({required this.stsNum});
}
