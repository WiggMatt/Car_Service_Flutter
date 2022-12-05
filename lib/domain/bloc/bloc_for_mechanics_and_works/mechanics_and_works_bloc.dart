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
    on<ChangedSelectedMechanicEvent>(_changeSelectedMechanicEvent);
    on<AddMechanicEvent>(_addMechanicEvent);
    on<DeleteMechanicEvent>(_deleteMechanicEvent);
    on<GetCurrentMechanicRowIDEvent>(_getCurrentMechanicRowIDEvent);
    on<FillWorkDescDropDownButtonEvent>(_fillWorkDescDropDownButtonEvent);
  }

  _loadingMechanicsAndWorksTable(LoadingMechanicsAndWorksTableEvent event,
      Emitter<MechanicsAndWorksState> emit) async {
    loadedModels = await repository.onStartLoadMechanicsAndWorksRows();
    emit(MechanicsAndWorksInitialState(
        mechanicsRows: loadedModels.loadedMechanicsList));
  }

  _addMechanicEvent(
      AddMechanicEvent event, Emitter<MechanicsAndWorksState> emit) async {
    await repository.onAddMechanic(event);
    add(LoadingMechanicsAndWorksTableEvent());
  }

  _deleteMechanicEvent(
      DeleteMechanicEvent event, Emitter<MechanicsAndWorksState> emit) async {
    await repository.onDeleteMechanic(event);
    add(LoadingMechanicsAndWorksTableEvent());
  }

  _changeSelectedMechanicEvent(ChangedSelectedMechanicEvent event,
      Emitter<MechanicsAndWorksState> emit) {
    _selectedMechanicRow = event.selectedRow!;
  }

  _getCurrentMechanicRowIDEvent(GetCurrentMechanicRowIDEvent event,
      Emitter<MechanicsAndWorksState> emit) {
    if (_selectedMechanicRow == -1 ||
        loadedModels.loadedMechanicsList.isEmpty) {
      return;
    } else {
      emit(
          MechanicCurrentRowIDInitialState(currentRowID: _selectedMechanicRow));
    }
  }

  _fillWorkDescDropDownButtonEvent(FillWorkDescDropDownButtonEvent event,
      Emitter<MechanicsAndWorksState> emit) {
    emit(FillWorkDescDropDownButtonInitialState(
        listOfWorks: loadedModels.listOfWorks));
  }
}
