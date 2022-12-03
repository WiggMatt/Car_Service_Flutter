part of 'contract_bloc.dart';

@immutable
abstract class ContractState {}

int _selectedContractRow = -1;
List<PlutoRow> _searchedRows = [];
late LoadingData loadedModels;

class ContractInitialState extends ContractState {
  final List<PlutoRow> contractsRows;

  ContractInitialState({required this.contractsRows});
}

class SearchedTableInitialState extends ContractState {
  final List<PlutoRow> searchedRows;

  SearchedTableInitialState({required this.searchedRows});
}

class ContractCurrentRowInitialState extends ContractState {
  final PlutoRow row;

  ContractCurrentRowInitialState({required this.row});
}

class CurrentModelAndBrandInitState extends ContractState {
  final String model;
  final String brand;

  CurrentModelAndBrandInitState({required this.model, required this.brand});
}

class FillAddEditAlertsInitState extends ContractState {
  final List<String> listOfSts;
  final List<String> listOfWorks;
  final List<String> listOfWorkers;
  final List<String> listOfPayment;
  final List<String> listOfReady;

  FillAddEditAlertsInitState({
    required this.listOfSts,
    required this.listOfWorks,
    required this.listOfWorkers,
    required this.listOfPayment,
    required this.listOfReady,
  });
}

class WorksForCurrentWorkerState extends ContractState {
  final List<String> listOfWorks;

  WorksForCurrentWorkerState({required this.listOfWorks});
}
