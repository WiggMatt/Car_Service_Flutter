import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/pages/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContractAlert extends StatefulWidget {
  const SearchContractAlert({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<SearchContractAlert> createState() => _SearchContractAlertState();
}

class _SearchContractAlertState extends State<SearchContractAlert> {
  List<String> listOfWorks = [''];
  List<String> listOfWorkers = [''];
  List<String> listOfPayment = [''];
  List<String> listOfSTS = [''];
  List<String> listOfReadiness = [''];

  @override
  void initState() {
    super.initState();
    dropdownWORKValue = listOfWorks.first;
    dropdownWORKERValue = listOfWorkers.first;
    dropdownSTSValue = listOfSTS.first;
    dropdownPaymentValue = listOfPayment.first;
    dropdownReadinessValue = listOfReadiness.first;
  }

  late String dropdownWORKValue;
  late String dropdownWORKERValue;
  late String dropdownSTSValue;
  late String dropdownPaymentValue;
  late String dropdownReadinessValue;

  int counter = 0;
  int counter2 = 0;
  var list;

  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.contractBloc.add(FillAddEditAlertsEvent());
    widget.contractBloc.add(SwitchSTSEvent(stsNum: dropdownSTSValue));
    widget.contractBloc.add(SwitchSurnameEvent(surname: dropdownWORKERValue));

    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is FillAddEditAlertsInitState && counter == 0) {
          setState(() {
            listOfWorks = state.listOfWorks;
            listOfWorkers = state.listOfWorkers;
            listOfSTS = state.listOfSts;
            listOfPayment = state.listOfPayment;
            listOfReadiness = state.listOfReady;
            dropdownWORKValue = listOfWorks.first;
            dropdownWORKERValue = listOfWorkers.first;
            dropdownSTSValue = listOfSTS.first;
            dropdownPaymentValue = listOfPayment.first;
            dropdownReadinessValue = listOfReadiness.first;
            counter++;
          });
        }
        if (state is CurrentModelAndBrandInitState) {
          carBrand.text = state.brand;
          carModel.text = state.model;
        }
        if (state is WorksForCurrentWorkerState && counter2 == 0) {
          setState(() {
            listOfWorks = state.listOfWorks;
            dropdownWORKValue = listOfWorks.first;
            counter2++;
          });
        }
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: const Text('Поиск записи'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Номер СТС',
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
                  value: dropdownSTSValue,
                  alignment: Alignment.center,
                  items:
                      listOfSTS.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownSTSValue = value!;
                    });
                  },
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
                maxLength: 10,
                controller: carBrand,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[A-Z-a-z]"))
                ],
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
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[A-Z-a-z]"))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Модель авто',
                ),
              ),
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
                  items: listOfWorkers
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownWORKERValue = value!;
                      counter2 = 0;
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
                  items: listOfPayment
                      .map<DropdownMenuItem<String>>((String value) {
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
              widget.contractBloc.add(SearchContractEvent(
                  stsNum: dropdownSTSValue,
                  carBrand: carBrand.text,
                  carModel: carModel.text,
                  workerName: dropdownWORKERValue,
                  workDesc: dropdownWORKValue,
                  readiness: dropdownReadinessValue,
                  payment: dropdownPaymentValue));

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchedContractsTableScreen(rows: list)));
            },
            child: const Text('Поиск'),
          ),
        ],
      ),
    );
  }
}
