import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContractAlert extends StatefulWidget {
  const EditContractAlert({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<EditContractAlert> createState() => _EditContractAlertState();
}

class _EditContractAlertState extends State<EditContractAlert> {
  List<String> listOfWorks = [''];
  List<String> listOfWorkers = [''];
  List<String> listOfPayment = [''];
  List<String> listOfReadiness = [''];

  @override
  void initState() {
    super.initState();
    dropdownWORKValue = listOfWorks.first;
    dropdownWORKERValue = listOfWorkers.first;
    dropdownPaymentValue = listOfPayment.first;
    dropdownReadinessValue = listOfReadiness.first;
  }

  late String dropdownWORKValue;
  late String dropdownWORKERValue;
  late String dropdownPaymentValue;
  late String dropdownReadinessValue;
  int counter = 0;
  int counter2 = 0;
  int counter3 = 0;

  TextEditingController stsNum = TextEditingController();
  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();

  late final String stsFromRow;
  late final String brandFromRow;
  late final String modelFromRow;
  late final String workFromRow;
  late final String workerFromRow;
  late final String paymentFromRow;
  late final String readinessFromRow;

  @override
  Widget build(BuildContext context) {
    widget.contractBloc.add(FillAddEditAlertsEvent());
    widget.contractBloc.add(GetCurrentRowEvent());
    if (dropdownWORKERValue != "") {
      widget.contractBloc.add(SwitchSurnameEvent(surname: dropdownWORKERValue));
    }

    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is ContractCurrentRowInitialState && counter3 == 0) {
          var row =
              state.row.cells.values.map((e) => e.value.toString()).toList();
          stsFromRow = row[0];
          brandFromRow = row[1];
          modelFromRow = row[2];
          workFromRow = row[3];
          workerFromRow = row[4];
          paymentFromRow = row[7];
          readinessFromRow = row[6];
          counter3++;
        }
        if (state is FillAddEditAlertsInitState && counter2 == 0) {
          setState(() {
            stsNum.text = stsFromRow;
            carBrand.text = brandFromRow;
            carModel.text = modelFromRow;
            listOfWorks = state.listOfWorks;
            listOfWorkers = state.listOfWorkers;
            listOfPayment = state.listOfPayment;
            listOfReadiness = state.listOfReady;
            for (var item in listOfWorks) {
              if (item == workFromRow) dropdownWORKValue = item;
            }
            for (var item in listOfWorkers) {
              if (item == workerFromRow) {
                dropdownWORKERValue = item;
              }
            }
            for (var item in listOfPayment) {
              if (item == paymentFromRow) dropdownPaymentValue = item;
            }
            for (var item in listOfReadiness) {
              if (item == readinessFromRow) dropdownReadinessValue = item;
            }
            counter2++;
          });
        }
        if (state is WorksForCurrentWorkerState && counter == 0) {
          setState(() {
            listOfWorks = state.listOfWorks;
            for (var item in listOfWorks) {
              if (item == workFromRow) {
                dropdownWORKValue = item;
              } else {
                dropdownWORKValue = listOfWorks.first;
              }
            }
            counter++;
          });
        }
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: const Text('Изменение записи'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                enabled: false,
                controller: stsNum,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Номер СТС',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                enabled: false,
                controller: carBrand,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Марка авто',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                enabled: false,
                controller: carModel,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Модель авто',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Фамилия работника',
                style: TextStyle(fontSize: 13, color: Colors.black38),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black38, width: 1.2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownWORKERValue,
                  alignment: Alignment.center,
                  items: listOfWorkers.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownWORKERValue = value!;
                      counter = 0;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Требуемая работа',
                style: TextStyle(fontSize: 13, color: Colors.black38),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black38, width: 1.2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownWORKValue,
                  alignment: Alignment.center,
                  items:
                      listOfWorks.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownWORKValue = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Оплата',
                style: TextStyle(fontSize: 13, color: Colors.black38),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black38, width: 1.2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownPaymentValue,
                  alignment: Alignment.center,
                  items: listOfPayment.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownPaymentValue = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Готовность',
                style: TextStyle(fontSize: 13, color: Colors.black38),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black38, width: 1.2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownReadinessValue,
                  alignment: Alignment.center,
                  items: listOfReadiness
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownReadinessValue = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.contractBloc.add(EditContractEvent(
                  stsNum: stsNum.text,
                  carBrand: carBrand.text,
                  carModel: carModel.text,
                  workDesc: dropdownWORKValue,
                  workerName: dropdownWORKERValue,
                  payment: dropdownPaymentValue,
                  readiness: dropdownReadinessValue));
            },
            child: const Text('Изменить'),
          ),
        ],
      ),
    );
  }
}
