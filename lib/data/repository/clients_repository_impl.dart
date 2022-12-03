import 'package:car_service/data/repository/querys.dart';
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
}
