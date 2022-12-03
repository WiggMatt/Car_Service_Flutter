import 'package:pluto_grid/pluto_grid.dart';

class LoadingData {
  List<String> listOfSts = [];
  List<String> listOfWorks = [];
  List<String> listOfWorkers = [];
  final List<String> listOfPayment = ['Не оплачено', 'Оплачено'];
  final List<String> listOfReady = ['В процессе', 'Выполнено'];
  List<PlutoRow> loadedClientsList = [];
  List<PlutoRow> loadedContractsList = [];
  List<PlutoRow> loadedMechanicsList = [];
}
