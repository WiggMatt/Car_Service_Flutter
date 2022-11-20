part of 'contract_bloc.dart';

@immutable
abstract class ContractState {}

List<PlutoRow> _contractsRows = [];
int _selectedContractRow = -1;

class ContractInitialState extends ContractState {
  final List<PlutoRow> contractsRows;

  ContractInitialState({required this.contractsRows});
}

class ContractCurrentRowInitialState extends ContractState {
  final PlutoRow row;

  ContractCurrentRowInitialState({required this.row});
}
