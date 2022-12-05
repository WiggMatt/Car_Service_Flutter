import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';

abstract class DomainMechanicsAndWorksRepository {
  Future<LoadingData> onStartLoadMechanicsAndWorksRows() async {
    throw Exception();
  }

  Future<void> onAddMechanic(AddMechanicEvent event) async {}

  Future<void> onDeleteMechanic(DeleteMechanicEvent event) async {}
}
