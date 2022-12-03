import 'package:car_service/domain/models/data_collection.dart';

abstract class DomainMechanicsAndWorksRepository {
  Future<LoadingData> onStartLoadMechanicsAndWorksRows() async {
    throw Exception();
  }
}
