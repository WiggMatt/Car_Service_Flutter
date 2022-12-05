part of 'mechanics_and_works_bloc.dart';

@immutable
abstract class MechanicsAndWorksEvent {}

class LoadingMechanicsAndWorksTableEvent extends MechanicsAndWorksEvent {}

class AddMechanicEvent extends MechanicsAndWorksEvent {
  final String firstName;
  final String lastName;
  final String workDesc;

  AddMechanicEvent({
    required this.firstName,
    required this.lastName,
    required this.workDesc,
  });
}

class DeleteMechanicEvent extends MechanicsAndWorksEvent {
  final String firstName;
  final String lastName;
  final String workDesc;

  DeleteMechanicEvent({
    required this.firstName,
    required this.lastName,
    required this.workDesc,
  });
}

class LoadingMechanicTableEvent extends MechanicsAndWorksEvent {}

class ChangedSelectedMechanicEvent extends MechanicsAndWorksEvent {
  final int? selectedRow;

  ChangedSelectedMechanicEvent({required this.selectedRow});
}

class GetCurrentMechanicRowIDEvent extends MechanicsAndWorksEvent {}

class FillWorkDescDropDownButtonEvent extends MechanicsAndWorksEvent {}
