import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';

abstract class DomainRepository {
  Future<LoadingData> onStartLoadContractRows() async {
    throw Exception();
  }

  Future<LoadingData> onStartLoadClientsRows() async {
    throw Exception();
  }

  Future<void> onAddContract(AddContractEvent event) async {}

  Future<List<String>> onSwitchSTS(SwitchSTSEvent event) async {
    throw Exception();
  }

  Future<List<String>> onSurnameSwitch(SwitchSurnameEvent event) async {
    throw Exception();
  }
}
