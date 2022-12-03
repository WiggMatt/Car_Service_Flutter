import 'package:car_service/data/repository/querys.dart';
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

  @override
  Future<LoadingData> onStartLoadMechanicsAndWorksRows() async {
    LoadingData loadingData = LoadingData();
    _dataBase = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _dataBase.rawQuery(loadMechanicsAndWorksTableQuery);

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
}
