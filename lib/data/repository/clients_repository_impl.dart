import 'package:car_service/data/repository/querys.dart';
import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:car_service/domain/repository/domain_repository_for_clients.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ClientsRepositoryImplementation implements DomainClientsRepository {
  final String _appSupportDirectory =
      r'D:\Programming\Android Projects\car_service\assets\database';

  late final String path;
  late var _dataBase;
  final databaseFactory = databaseFactoryFfi;

  ClientsRepositoryImplementation() {
    sqfliteFfiInit();
    path = "$_appSupportDirectory\\database.db";
  }

  @override
  Future<LoadingData> onStartLoadClientsRows() async {
    LoadingData loadingData = LoadingData();
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _dataBase.rawQuery(loadClientsTableQuery);

    for (var item in maps) {
      PlutoRow row = PlutoRow(cells: {
        'brand_field': PlutoCell(value: item['carBrand']),
        'model_field': PlutoCell(value: item['carModel']),
        'sts_field': PlutoCell(value: item['stsNum']),
        'name_field': PlutoCell(value: item['firstName']),
        'surname_field': PlutoCell(value: item['lastName']),
        'telephone_field': PlutoCell(value: item['telephoneNum']),
      });
      loadingData.loadedClientsList.add(row);
    }
    await _dataBase.close();
    return loadingData;
  }

  @override
  Future<void> onAddClient(AddClientEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);

    final List<Map<String, dynamic>> checkClientID = await _dataBase
        .rawQuery(getClientIDByNameQuery, [event.firstName, event.lastName]);

    if (checkClientID.isEmpty) {
      await _dataBase.rawInsert(addClientQuery,
          [event.firstName, event.lastName, int.parse(event.telephoneNum)]);
      var clientID = await _dataBase
          .rawQuery(getClientIDByNameQuery, [event.firstName, event.lastName]);
      await _dataBase.rawInsert(addCarsQuery, [
        int.parse(event.stsNum),
        event.carBrand,
        event.carModel,
        clientID[0]["clientID"]
      ]);
    } else {
      await _dataBase.rawInsert(addCarsQuery, [
        int.parse(event.stsNum),
        event.carBrand,
        event.carModel,
        checkClientID[0]["clientID"]
      ]);
    }

    await _dataBase.close();
  }

  @override
  Future<void> onDeleteClient(int clientID, int stsNum) async {
    _dataBase = await databaseFactory.openDatabase(path);

    await _dataBase.rawDelete(deleteCarQuery, [clientID, stsNum]);

    final List<Map<String, dynamic>> checkCars =
        await _dataBase.rawQuery(getOwnerIDQuery, [clientID]);

    if (checkCars.isEmpty) {
      await _dataBase.rawDelete(deleteClientQuery, [clientID]);
    }

    await _dataBase.close();
  }

  @override
  Future<List<int>> onChangeSelectedRow(
      ChangedSelectedClientEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    var clientRow = loadedModels
        .loadedClientsList[event.selectedRow!].cells.values
        .map((e) => e.value);
    String firstName = clientRow.elementAt(3);
    String lastName = clientRow.elementAt(4);
    int stsNum = int.parse(clientRow.elementAt(2));

    final List<Map<String, dynamic>> clientIDMaps =
        await _dataBase.rawQuery(getClientIDByNameQuery, [firstName, lastName]);

    List<int> result = [];
    result.add(clientIDMaps.first['clientID']);
    result.add(stsNum);

    await _dataBase.close();
    return result;
  }
}
