import 'package:car_service/domain/models/data_collection.dart';

abstract class DomainClientsRepository {
  Future<LoadingData> onStartLoadClientsRows() async {
    throw Exception();
  }
}
