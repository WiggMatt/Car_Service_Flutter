import 'package:car_service/data/repository/querys.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:car_service/domain/repository/domain_repository_for_contracts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ContractsRepositoryImplementation implements DomainContractsRepository {
  final String _appSupportDirectory =
      r'D:\Programming\Android Projects\car_service\assets\database';

  late final String path;
  late var _dataBase;
  final databaseFactory = databaseFactoryFfi;

  ContractsRepositoryImplementation() {
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
      loadingData.loadedContractsList.add(row);
    }
    await _dataBase.close();
    return loadingData;
  }

  @override
  Future<void> onAddContract(AddContractEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    await _dataBase.rawInsert(addContractQuery, [
      int.parse(event.stsNum),
      event.payment == "Не оплачено" ? 0 : 1,
      event.workDesc,
      event.workerName
    ]);
    await _dataBase.close();
  }

  @override
  Future<List<String>> onSwitchSTS(SwitchSTSEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    List<String> list = [];
    final List<Map<String, dynamic>> modelsAndBrandsMap = await _dataBase
        .rawQuery(getBrandAndModelOfCarQuery, [int.parse(event.stsNum)]);
    for (var item in modelsAndBrandsMap) {
      list.add(item['carBrand']);
      list.add(item['carModel']);
    }
    return list;
    await _dataBase.close();
  }

  @override
  Future<List<String>> onSurnameSwitch(SwitchSurnameEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    List<String> list = [];
    final List<Map<String, dynamic>> modelsAndBrandsMap =
        await _dataBase.rawQuery(getWorksDescBySurnameQuery, [event.surname]);
    for (var item in modelsAndBrandsMap) {
      list.add(item['repairDescription']);
    }
    return list;
    await _dataBase.close();
  }

  @override
  Future<void> onDeleteContract(int stsNum, String workDesc) async {
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps = await _dataBase
        .rawQuery(getSpecIDBySTSAndWorkDescQuery, [stsNum, workDesc]);
    int specId = maps.first['specId'];
    await _dataBase.rawDelete(deleteContractQuery, [stsNum, specId]);
    await _dataBase.close();
  }

  @override
  Future<void> onEditContractAlert(
      EditContractEvent event, PlutoRow oldValuesList) async {
    var oldValues =
        oldValuesList.cells.values.map((e) => e.value.toString()).toList();

    _dataBase = await databaseFactory.openDatabase(path);

    List<Map> oldSpecID = await _dataBase.rawQuery(
        getSpecIDBySTSAndWorkDescQuery,
        [int.parse(event.stsNum), oldValues[3]]);

    var newSpecID = await _dataBase.rawQuery(
        newSpecIDForEditContractQuery, [event.workerName, event.workDesc]);

    var contractNum = await _dataBase.rawQuery(getContractNumBySTSAndSpecID,
        [oldSpecID[0]["specId"], int.parse(event.stsNum)]);

    await _dataBase.rawUpdate(editContractQuery, [
      newSpecID[0]["specId"],
      event.payment == "Оплачено" ? 1 : 0,
      event.readiness == "Выполнено" ? 1 : 0,
      contractNum[0]["contractNum"]
    ]);
    await _dataBase.close();
  }
}
