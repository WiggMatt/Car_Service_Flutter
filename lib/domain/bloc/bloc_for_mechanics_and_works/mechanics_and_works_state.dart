part of 'mechanics_and_works_bloc.dart';

@immutable
abstract class MechanicsAndWorksState {}

class MechanicsAndWorksInitialState extends MechanicsAndWorksState {
  final List<PlutoRow> mechanicsRows;

  MechanicsAndWorksInitialState({required this.mechanicsRows});
}
