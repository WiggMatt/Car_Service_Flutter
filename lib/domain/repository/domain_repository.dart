import 'package:car_service/domain/models/data_collection.dart';

abstract class DomainRepository {
  Future<LoadingData> onStartLoadContractRows() async {
    throw Exception();
  }

  Future<void> onAddContract(int stsNum, String carBrand, String carModel,
      int workerID, int workID) async {}
}
