import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:pluto_grid/pluto_grid.dart';

abstract class DomainClientsRepository {
  Future<LoadingData> onStartLoadClientsRows() async {
    throw Exception();
  }

  Future<void> onAddClient(AddClientEvent event) async {}

  Future<void> onDeleteClient(int clientID, int stsNum) async {}

  Future<List<int>> onChangeSelectedRow(
      ChangedSelectedClientEvent event) async {
    throw Exception();
  }
}
