import 'package:bloc/bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:car_service/domain/repository/domain_repository_for_contracts.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc({required this.repository})
      : super(ContractInitialState(contractsRows: [])) {
    on<AddContractEvent>(_addContractEvent);
    on<ChangedSelectedContractEvent>(_changeSelectedContractEvent);
    on<DeleteContractEvent>(_deleteContractEvent);
    on<EditContractEvent>(_editContractEvent);
    on<GetCurrentRowEvent>(_getCurrentRowEvent);
    on<SearchContractEvent>(_searchContractEvent);
    on<LoadingContractsTableEvent>(_loadingContractsTable);
    on<FillAddEditAlertsEvent>(_fillAddEditAlerts);
    on<SwitchSTSEvent>(_switchSTSEvent);
    on<SwitchSurnameEvent>(_switchSurnameEvent);
  }

  final DomainContractsRepository repository;

  _switchSurnameEvent(
      SwitchSurnameEvent event, Emitter<ContractState> emit) async {
    final list = await repository.onSurnameSwitch(event);
    emit(WorksForCurrentWorkerState(listOfWorks: list));
  }

  _switchSTSEvent(SwitchSTSEvent event, Emitter<ContractState> emit) async {
    final list = await repository.onSwitchSTS(event);
    emit(CurrentModelAndBrandInitState(model: list.last, brand: list.first));
  }

  _fillAddEditAlerts(
      FillAddEditAlertsEvent event, Emitter<ContractState> emit) {
    emit(FillAddEditAlertsInitState(
        listOfSts: loadedModels.listOfSts,
        listOfWorks: loadedModels.listOfWorks,
        listOfWorkers: loadedModels.listOfWorkers,
        listOfPayment: loadedModels.listOfPayment,
        listOfReady: loadedModels.listOfReady));
  }

  _loadingContractsTable(
      LoadingContractsTableEvent event, Emitter<ContractState> emit) async {
    loadedModels = await repository.onStartLoadContractRows();
    emit(ContractInitialState(contractsRows: loadedModels.loadedContractsList));
  }

  _addContractEvent(AddContractEvent event, Emitter<ContractState> emit) async {
    await repository.onAddContract(event);
    add(LoadingContractsTableEvent());
  }

  _changeSelectedContractEvent(
      ChangedSelectedContractEvent event, Emitter<ContractState> emit) {
    _selectedContractRow = event.selectedRow!;
  }

  _deleteContractEvent(
      DeleteContractEvent event, Emitter<ContractState> emit) async {
    var contractRow = loadedModels
        .loadedContractsList[_selectedContractRow].cells.values
        .map((e) => e.value);
    int stsNum = contractRow.elementAt(0);
    String workDesc = contractRow.elementAt(3);
    await repository.onDeleteContract(stsNum, workDesc);
    add(LoadingContractsTableEvent());
  }

  _editContractEvent(
      EditContractEvent event, Emitter<ContractState> emit) async {
    await repository.onEditContractAlert(
        event, loadedModels.loadedContractsList[_selectedContractRow]);
    add(LoadingContractsTableEvent());
  }

  _getCurrentRowEvent(GetCurrentRowEvent event, Emitter<ContractState> emit) {
    if (_selectedContractRow == -1 ||
        loadedModels.loadedContractsList.isEmpty) {
      return;
    } else {
      emit(ContractCurrentRowInitialState(
          row: loadedModels.loadedContractsList[_selectedContractRow]));
    }
  }

  _searchContractEvent(SearchContractEvent event, Emitter<ContractState> emit) {
    _searchedRows.clear();
    if (loadedModels.loadedContractsList.isEmpty) {
      return;
    } else {
      for (var item in loadedModels.loadedContractsList) {
        var contractRow = item.cells.values.map((e) => e.value);
        if (contractRow.elementAt(0) == event.stsNum &&
            contractRow.elementAt(1) == event.carBrand &&
            contractRow.elementAt(2) == event.carModel) {
          _searchedRows.add(item);
        } else if (contractRow.elementAt(0) != "" &&
            contractRow.elementAt(0) == event.stsNum) {
          _searchedRows.add(item);
        } else if (contractRow.elementAt(1) == event.carBrand &&
            contractRow.elementAt(2) == event.carModel) {
          _searchedRows.add(item);
        } else if (contractRow.elementAt(6) == event.readiness &&
            contractRow.elementAt(7) == event.payment) {
          _searchedRows.add(item);
        } else if (contractRow.elementAt(6) == event.readiness &&
            event.payment == "") {
          _searchedRows.add(item);
        } else if (contractRow.elementAt(7) == event.payment &&
            event.readiness == "") {
          _searchedRows.add(item);
        }
      }
      emit(SearchedTableInitialState(searchedRows: _searchedRows));
    }
  }
}
