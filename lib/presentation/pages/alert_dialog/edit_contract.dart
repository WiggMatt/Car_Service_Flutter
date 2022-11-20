import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<int> list1 = <int>[1, 2, 3, 4];
List<int> list2 = <int>[11, 22, 33, 44];

class EditContractAlert extends StatefulWidget {
  const EditContractAlert({Key? key, required this.contractBloc})
      : super(key: key);

  final ContractBloc contractBloc;

  @override
  State<EditContractAlert> createState() => _EditContractAlertState();
}

class _EditContractAlertState extends State<EditContractAlert> {
  @override
  void initState() {
    super.initState();
    dropdown1Value = list1.first;
    dropdown2Value = list2.first;
  }

  late int dropdown1Value;
  late int dropdown2Value;

  TextEditingController sts = TextEditingController();
  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();

  bool validateCarBrandTextField = false;
  bool validateCarModelTextField = false;
  bool validateSTSTextField = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is ContractCurrentRowInitialState) {
          var row =
              state.row.cells.values.map((e) => e.value.toString()).toList();
          setState(() {
            sts.text = row[0];
            carBrand.text = row[1];
            carModel.text = row[2];
            dropdown1Value = int.parse(row[3]);
            dropdown2Value = int.parse(row[4]);
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
                maxLength: 6,
                controller: sts,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Номер СТС',
                  errorText: validateSTSTextField ? 'Требуется ввод' : null,
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
                  value: dropdown1Value,
                  alignment: Alignment.center,
                  items: list1.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdown1Value = value!;
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
                  value: dropdown2Value,
                  alignment: Alignment.center,
                  items: list2.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdown2Value = value!;
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
              if (carModel.text.isEmpty ||
                  carBrand.text.isEmpty ||
                  sts.text.isEmpty) {
                setState(() {
                  validateCarBrandTextField = true;
                  validateCarModelTextField = true;
                  validateSTSTextField = true;
                });
              } else {
                Navigator.pop(context);
                widget.contractBloc.add(EditContractEvent(
                    stsNum: int.parse(sts.text),
                    carBrand: carBrand.text,
                    carModel: carModel.text,
                    workID: dropdown1Value,
                    workerID: dropdown2Value));
              }
            },
            child: const Text('Изменить'),
          ),
        ],
      ),
    );
  }
}
