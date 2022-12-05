import 'package:car_service/data/repository/querys.dart';
import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/domain/models/data_collection.dart';
import 'package:car_service/domain/repository/domain_repository_for_mechanics_and_works.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MechanicsAndWorksRepositoryImplementation
    implements DomainMechanicsAndWorksRepository {
  final String _appSupportDirectory =
      r'D:\Programming\Android Projects\car_service\assets\database';

  late final String path;
  late var _dataBase;
  final databaseFactory = databaseFactoryFfi;

  MechanicsAndWorksRepositoryImplementation() {
    sqfliteFfiInit();
    path = "$_appSupportDirectory\\database.db";
  }

  Future<List<String>> _getWorks() async {
    List<String> list = [];
    final List<Map<String, dynamic>> worksMap =
        await _dataBase.rawQuery(getAllWorksQuery);
    for (var item in worksMap) {
      list.add(item['repairDescription']);
    }
    return list;
  }

  @override
  Future<LoadingData> onStartLoadMechanicsAndWorksRows() async {
    LoadingData loadingData = LoadingData();
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _dataBase.rawQuery(loadMechanicsAndWorksTableQuery);

    loadingData.listOfWorks = await _getWorks();

    for (var item in maps) {
      PlutoRow row = PlutoRow(cells: {
        'name_field': PlutoCell(value: item['firstName']),
        'surname_field': PlutoCell(value: item['lastName']),
        'work_description_field': PlutoCell(value: item['repairDescription']),
        'work_coast_field': PlutoCell(value: item['coast']),
      });
      loadingData.loadedMechanicsList.add(row);
    }
    await _dataBase.close();
    return loadingData;
  }

  @override
  Future<void> onAddMechanic(AddMechanicEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> repairMaps =
        await _dataBase.rawQuery(getRepairIDQuery, [event.workDesc]);

    final List<Map<String, dynamic>> checkMaps = await _dataBase
        .rawQuery(getMechanicIDQuery, [event.firstName, event.lastName]);

    if (checkMaps.isEmpty) {
      await _dataBase
          .rawInsert(addMechanicsQuery, [event.firstName, event.lastName]);
      final List<Map<String, dynamic>> mechanicMaps = await _dataBase
          .rawQuery(getMechanicIDQuery, [event.firstName, event.lastName]);

      await _dataBase.rawInsert(addMechanicSpecQuery,
          [mechanicMaps.first['mechanicId'], repairMaps.first['repairId']]);
    } else {
      await _dataBase.rawInsert(addMechanicSpecQuery,
          [checkMaps.first['mechanicId'], repairMaps.first['repairId']]);
    }
    await _dataBase.close();
  }

  @override
  Future<void> onDeleteMechanic(DeleteMechanicEvent event) async {
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> mechanicMaps = await _dataBase
        .rawQuery(getMechanicIDQuery, [event.firstName, event.lastName]);

    final List<Map<String, dynamic>> repairMaps =
        await _dataBase.rawQuery(getRepairIDQuery, [event.workDesc]);

    await _dataBase.rawDelete(deleteMechanicSpecQuery,
        [mechanicMaps.first['mechanicId'], repairMaps.first['repairId']]);

    final List<Map<String, dynamic>> checkMaps = await _dataBase
        .rawQuery(getSpecIDByMechanicID, [mechanicMaps.first['mechanicId']]);

    if (checkMaps.isEmpty) {
      await _dataBase
          .rawDelete(deleteMechanicQuery, [mechanicMaps.first['mechanicId']]);
    }

    await _dataBase.close();
  }
}
