import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/pages/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<int> listOfWorks = <int>[1, 2, 3, 4];
List<int> listOfWorkers = <int>[11, 22, 33, 44];
List<int> listOfSTS = <int>[154265, 195728, 105732];

class SearchContractAlert extends StatefulWidget {
  const SearchContractAlert({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<SearchContractAlert> createState() => _SearchContractAlertState();
}

class _SearchContractAlertState extends State<SearchContractAlert> {
  @override
  void initState() {
    super.initState();
    dropdownWORKValue = listOfWorks.first;
    dropdownWORKERValue = listOfWorkers.first;
    dropdownSTSValue = listOfSTS.first;
  }

  late int dropdownWORKValue;
  late int dropdownWORKERValue;
  late int dropdownSTSValue;
  var list;

  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();

  bool validateCarBrandTextField = false;
  bool validateCarModelTextField = false;

  @override
  Widget build(BuildContext context) {
    widget.contractBloc
        .add(SearchAlertEvent(stsNum: dropdownSTSValue.toString()));
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is SearchedTableInitialState) {
          list = state.searchedRows;
        }
        if (state is CurrentModelAndBrandInitState) {
          setState(() {
            carBrand.text = state.brand;
            carModel.text = state.model;
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
                child: DropdownButton<int>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownSTSValue,
                  alignment: Alignment.center,
                  items: listOfSTS.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Марка авто',
                  errorText:
                      validateCarBrandTextField ? 'Требуется ввод' : null,
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Модель авто',
                  errorText:
                      validateCarModelTextField ? 'Требуется ввод' : null,
                ),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'ID работника',
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
                child: DropdownButton<int>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownWORKValue,
                  alignment: Alignment.center,
                  items: listOfWorks.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
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
            const SizedBox(width: 30),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'ID работы',
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
                child: DropdownButton<int>(
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  value: dropdownWORKERValue,
                  alignment: Alignment.center,
                  items: listOfWorkers.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownWORKERValue = value!;
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
              if (carBrand.text.isEmpty && carModel.text.isEmpty) {
                setState(() {
                  validateCarBrandTextField = true;
                  validateCarModelTextField = true;
                });
              } else if (carModel.text.isEmpty) {
                setState(() {
                  validateCarModelTextField = true;
                });
              } else if (carBrand.text.isEmpty) {
                setState(() {
                  validateCarBrandTextField = true;
                });
              } else {
                widget.contractBloc.add(SearchContractEvent(
                    stsNum: dropdownSTSValue,
                    carBrand: carBrand.text,
                    carModel: carModel.text,
                    workerID: dropdownWORKERValue,
                    workID: dropdownWORKValue));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchedContractsTableScreen(rows: list)));
              }
            },
            child: const Text('Поиск'),
          ),
        ],
      ),
    );
  }
}
