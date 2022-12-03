import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/repository/domain_repository_for_mechanics_and_works.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'mechanics_and_works_event.dart';

part 'mechanics_and_works_state.dart';

class MechanicsAndWorksBloc
    extends Bloc<MechanicsAndWorksEvent, MechanicsAndWorksState> {
  final DomainMechanicsAndWorksRepository repository;

  MechanicsAndWorksBloc({required this.repository})
      : super(MechanicsAndWorksInitialState(mechanicsRows: [])) {
    on<LoadingMechanicsAndWorksTableEvent>(_loadingMechanicsAndWorksTable);
  }

  _loadingMechanicsAndWorksTable(LoadingMechanicsAndWorksTableEvent event,
      Emitter<MechanicsAndWorksState> emit) async {
    loadedModels = await repository.onStartLoadMechanicsAndWorksRows();
    emit(MechanicsAndWorksInitialState(
        mechanicsRows: loadedModels.loadedMechanicsList));
  }
}
