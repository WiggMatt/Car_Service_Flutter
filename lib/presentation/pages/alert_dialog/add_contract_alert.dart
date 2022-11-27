import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContractAlert extends StatefulWidget {
  const AddContractAlert({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<AddContractAlert> createState() => _AddContractAlertState();
}

class _AddContractAlertState extends State<AddContractAlert> {
  List<String> listOfWorks = [''];
  List<String> listOfWorkers = [''];
  List<String> listOfPayment = [''];
  List<String> listOfSTS = [''];

  @override
  void initState() {
    super.initState();
    dropdownWORKValue = listOfWorks.first;
    dropdownWORKERValue = listOfWorkers.first;
    dropdownSTSValue = listOfSTS.first;
    dropdownPaymentValue = listOfPayment.first;
  }

  late String dropdownWORKValue;
  late String dropdownWORKERValue;
  late String dropdownSTSValue;
  late String dropdownPaymentValue;
  int counter = 0;

  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();

  bool validateCarBrandTextField = false;
  bool validateCarModelTextField = false;

  @override
  Widget build(BuildContext context) {
    widget.contractBloc.add(FillAddEditAlertsEvent());
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is FillAddEditAlertsInitState && counter == 0) {
          setState(() {
            listOfWorks = state.listOfWorks;
            listOfWorkers = state.listOfWorkers;
            listOfSTS = state.listOfSts;
            listOfPayment = state.listOfPayment;
            dropdownWORKValue = listOfWorks.first;
            dropdownWORKERValue = listOfWorkers.first;
            dropdownSTSValue = listOfSTS.first;
            dropdownPaymentValue = listOfPayment.first;
            counter++;
          });
        }
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: const Text('Новая запись'),
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
            const SizedBox(width: 30),
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
                Navigator.pop(context, []);
                widget.contractBloc.add(AddContractEvent(
                    stsNum: dropdownSTSValue,
                    carBrand: carBrand.text,
                    carModel: carModel.text,
                    workDesc: dropdownWORKValue,
                    workerName: dropdownWORKERValue,
                    payment: dropdownPaymentValue));
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
