part of 'mechanics_and_works_bloc.dart';

@immutable
abstract class MechanicsAndWorksState {}

int _selectedMechanicRow = -1;

int getCurrRow() {
  return _selectedMechanicRow;
}

class MechanicsAndWorksInitialState extends MechanicsAndWorksState {
  final List<PlutoRow> mechanicsRows;

  MechanicsAndWorksInitialState({required this.mechanicsRows});
}

class MechanicCurrentRowIDInitialState extends MechanicsAndWorksState {
  final int currentRowID;

  MechanicCurrentRowIDInitialState({required this.currentRowID});
}

class FillWorkDescDropDownButtonInitialState extends MechanicsAndWorksState {
  final List<String> listOfWorks;

  FillWorkDescDropDownButtonInitialState({required this.listOfWorks});
}
