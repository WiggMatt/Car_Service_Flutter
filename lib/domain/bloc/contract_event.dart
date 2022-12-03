part of 'contract_bloc.dart';

@immutable
abstract class ContractEvent {}

class AddContractEvent extends ContractEvent {
  final String stsNum;
  final String carBrand;
  final String carModel;
  final String workerName;
  final String workDesc;
  final String payment;

  AddContractEvent(
      {required this.stsNum,
      required this.carBrand,
      required this.carModel,
      required this.workerName,
      required this.workDesc,
      required this.payment});
}

class DeleteContractEvent extends ContractEvent {}

class ChangedSelectedContractEvent extends ContractEvent {
  final int? selectedRow;

  ChangedSelectedContractEvent({required this.selectedRow});
}

class EditContractEvent extends ContractEvent {
  final String stsNum;
  final String carBrand;
  final String carModel;
  final String workerName;
  final String workDesc;
  final String payment;
  final String readiness;

  EditContractEvent({
    required this.stsNum,
    required this.carBrand,
    required this.carModel,
    required this.workerName,
    required this.workDesc,
    required this.payment,
    required this.readiness,
  });
}

class GetCurrentRowEvent extends ContractEvent {}

class SearchContractEvent extends ContractEvent {
  final String stsNum;
  final String carBrand;
  final String carModel;
  final String workerName;
  final String workDesc;
  final String payment;
  final String readiness;

  SearchContractEvent({
    required this.stsNum,
    required this.carBrand,
    required this.carModel,
    required this.workerName,
    required this.workDesc,
    required this.payment,
    required this.readiness,
  });
}

class SearchAlertEvent extends ContractEvent {
  final String stsNum;

  SearchAlertEvent({required this.stsNum});
}

class LoadingContractsTableEvent extends ContractEvent {}

class FillAddEditAlertsEvent extends ContractEvent {}

class SwitchSTSEvent extends ContractEvent {
  final String stsNum;

  SwitchSTSEvent({required this.stsNum});
}

class SwitchSurnameEvent extends ContractEvent {
  final String surname;

  SwitchSurnameEvent({required this.surname});
}
