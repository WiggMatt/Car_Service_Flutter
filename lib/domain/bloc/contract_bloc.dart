import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc() : super(ContractInitialState(contractsRows: [])) {
    on<AddContractEvent>(_addContractEvent);
    on<ChangedSelectedContractEvent>(_changeSelectedContractEvent);
    on<DeleteContractEvent>(_deleteContractEvent);
    on<EditContractEvent>(_editContractEvent);
    on<GetCurrentRowEvent>(_getCurrentRowEvent);
    on<SearchContractEvent>(_searchContractEvent);
    on<SearchAlertEvent>(_changeSearchAlert);
  }

  _addContractEvent(AddContractEvent event, Emitter<ContractState> emit) {
    final item = PlutoRow(cells: {
      'sts_field': PlutoCell(value: event.stsNum),
      'brand_auto_field': PlutoCell(value: event.carBrand),
      'model_auto_field': PlutoCell(value: event.carModel),
      'work_field': PlutoCell(value: event.workID),
      'worker_field': PlutoCell(value: event.workerID),
    });
    _contractsRows.add(item);
    emit(ContractInitialState(contractsRows: _contractsRows));
  }

  _changeSelectedContractEvent(
      ChangedSelectedContractEvent event, Emitter<ContractState> emit) {
    _selectedContractRow = event.selectedRow!;
  }

  _deleteContractEvent(DeleteContractEvent event, Emitter<ContractState> emit) {
    _contractsRows.removeAt(_selectedContractRow);
    emit(ContractInitialState(contractsRows: _contractsRows));
  }

  _editContractEvent(EditContractEvent event, Emitter<ContractState> emit) {
    final item = PlutoRow(cells: {
      'sts_field': PlutoCell(value: event.stsNum),
      'brand_auto_field': PlutoCell(value: event.carBrand),
      'model_auto_field': PlutoCell(value: event.carModel),
      'work_field': PlutoCell(value: event.workID),
      'worker_field': PlutoCell(value: event.workerID),
    });
    _contractsRows[_selectedContractRow] = item;
    emit(ContractInitialState(contractsRows: _contractsRows));
  }

  _getCurrentRowEvent(GetCurrentRowEvent event, Emitter<ContractState> emit) {
    if (_selectedContractRow == -1 || _contractsRows.isEmpty) {
      return;
    } else {
      emit(ContractCurrentRowInitialState(
          row: _contractsRows[_selectedContractRow]));
    }
  }

  _searchContractEvent(SearchContractEvent event, Emitter<ContractState> emit) {
    _searchedRows.clear();
    if (_contractsRows.isEmpty) {
      return;
    } else if (event.carBrand.isNotEmpty && event.carModel.isNotEmpty) {
      for (var item in _contractsRows) {
        var contactRow = item.cells.values.map((e) => e.value);
        if (contactRow.elementAt(1) == event.carBrand &&
            contactRow.elementAt(2) == event.carModel) {
          _searchedRows.add(item);
        }
      }
      emit(SearchedTableInitialState(searchedRows: _searchedRows));
    }
  }

  _changeSearchAlert(SearchAlertEvent event, Emitter<ContractState> emit) {
    if (_contractsRows.isEmpty) {
      return;
    } else {
      for (var item in _contractsRows) {
        var contactRow = item.cells.values.map((e) => e.value);
        if (contactRow.elementAt(0).toString() == event.stsNum) {
          var currentModel = contactRow.elementAt(2);
          var currentBrand = contactRow.elementAt(1);
          emit(SearchAlertInitState(model: currentModel, brand: currentBrand));
          break;
        }
      }
    }
  }
}
