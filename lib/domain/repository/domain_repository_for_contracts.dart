import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:pluto_grid/pluto_grid.dart';

abstract class DomainContractsRepository {
  Future<LoadingData> onStartLoadContractRows() async {
    throw Exception();
  }

  Future<void> onAddContract(AddContractEvent event) async {}

  Future<void> onDeleteContract(int stsNum, String workDesc) async {}

  Future<List<String>> onSwitchSTS(SwitchSTSEvent event) async {
    throw Exception();
  }

  Future<List<String>> onSurnameSwitch(SwitchSurnameEvent event) async {
    throw Exception();
  }

  Future<void> onEditAlert(
      EditContractEvent event, PlutoRow oldValuesList) async {
    throw Exception();
  }
}
