import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMechanicAlert extends StatefulWidget {
  const AddMechanicAlert({Key? key, required this.mechanicBloc})
      : super(key: key);

  final MechanicsAndWorksBloc mechanicBloc;

  @override
  State<AddMechanicAlert> createState() => _AddMechanicAlertState();
}

class _AddMechanicAlertState extends State<AddMechanicAlert> {
  List<String> listOfWorks = [''];

  @override
  void initState() {
    super.initState();
    dropdownWORKValue = listOfWorks.first;
  }

  late String dropdownWORKValue;
  int counter = 0;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MechanicsAndWorksBloc, MechanicsAndWorksState>(
      listener: (context, state) {
        if (state is FillWorkDescDropDownButtonInitialState && counter == 0) {
          setState(() {
            listOfWorks = state.listOfWorks;
            dropdownWORKValue = listOfWorks.first;
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
            SizedBox(
              width: 200,
              child: TextField(
                maxLength: 10,
                controller: firstName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[А-Я-а-я]"))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Имя механика',
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
                controller: lastName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[А-Я-а-я]"))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Фамилия механика',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 5, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Описание работы',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (firstName.text.isEmpty || lastName.text.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const SimpleDialog(
                        title: Text("Предупреждение",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30)),
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        children: [
                          Text(
                            "Все поля должны быть заполнены!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      );
                    });
              } else {
                Navigator.pop(context, []);
                widget.mechanicBloc.add(AddMechanicEvent(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    workDesc: dropdownWORKValue));
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
