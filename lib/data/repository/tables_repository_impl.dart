import 'package:car_service/data/repository/querys.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:car_service/domain/repository/domain_repository.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid/src/model/pluto_row.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TablesRepositoryImplementation implements DomainRepository {
  final String _appSupportDirectory =
      r'D:\Programming\Android Projects\car_service\assets\database';

  late final String path;
  late var _dataBase;
  final databaseFactory = databaseFactoryFfi;

  TablesRepositoryImplementation() {
    sqfliteFfiInit();
    path = "$_appSupportDirectory\\database.db";
  }

  Future<List<String>> _getSts() async {
    List<String> list = [];
    final List<Map<String, dynamic>> stsMap =
        await _dataBase.rawQuery(getAllStsQuery);
    for (var item in stsMap) {
      list.add(item['stsNum']);
    }
    return list;
  }

  Future<List<String>> _getWorks() async {
    List<String> list = [];
    final List<Map<String, dynamic>> stsMap =
        await _dataBase.rawQuery(getAllWorksQuery);
    for (var item in stsMap) {
      list.add(item['repairDescription']);
    }
    return list;
  }

  Future<List<String>> _getWorkers() async {
    List<String> list = [];
    final List<Map<String, dynamic>> stsMap =
        await _dataBase.rawQuery(getAllWorkersQuery);
    for (var item in stsMap) {
      list.add(item['lastName']);
    }
    return list;
  }

  @override
  Future<LoadingData> onStartLoadContractRows() async {
    LoadingData loadingData = LoadingData();
    _dataBase = await databaseFactory.openDatabase(path);

    loadingData.listOfSts = await _getSts();
    loadingData.listOfWorks = await _getWorks();
    loadingData.listOfWorkers = await _getWorkers();

    final List<Map<String, dynamic>> maps =
        await _dataBase.rawQuery(loadContractTableQuery);

    for (var item in maps) {
      PlutoRow row = PlutoRow(cells: {
        'sts_field': PlutoCell(value: item['stsNum']),
        'brand_auto_field': PlutoCell(value: item['carBrand']),
        'model_auto_field': PlutoCell(value: item['carModel']),
        'work_field': PlutoCell(value: item['repairDescription']),
        'worker_field': PlutoCell(value: item['lastName']),
        'coast_field': PlutoCell(value: item['coast']),
        'ready_field': PlutoCell(
            value: item['isCompleted'] == 0 ? 'В процессе' : 'Выполнено'),
        'payment_field': PlutoCell(
            value: item['isPaidFor'] == 0 ? 'Не оплачено' : 'Оплачено'),
      });
      loadingData.loadedList.add(row);
    }
    await _dataBase.close();
    return loadingData;
  }

  @override
  Future<void> onAddContract(int stsNum, String carBrand, String carModel,
      int workerID, int workID) async {}
}
