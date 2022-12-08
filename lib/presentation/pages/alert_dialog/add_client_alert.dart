import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddClientAlert extends StatefulWidget {
  const AddClientAlert({Key? key, required this.clientBloc}) : super(key: key);

  final ClientBloc clientBloc;

  @override
  State<AddClientAlert> createState() => _AddClientAlertState();
}

class _AddClientAlertState extends State<AddClientAlert> {
  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController stsNum = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController telephoneNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Новая запись'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
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
              maxLength: 10,
              controller: carModel,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[A-Z-a-z-0-9]"))
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Модель авто',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              controller: stsNum,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
              ],
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
              maxLength: 10,
              controller: firstName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[А-Я-а-я]"))
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Имя владельца',
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
                labelText: 'Фамилия владельца',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              maxLength: 11,
              controller: telephoneNum,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Номер телефона',
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (carBrand.text.isEmpty ||
                carModel.text.isEmpty ||
                stsNum.text.isEmpty ||
                firstName.text.isEmpty ||
                lastName.text.isEmpty ||
                telephoneNum.text.isEmpty) {
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
              widget.clientBloc.add(AddClientEvent(
                  stsNum: stsNum.text,
                  carBrand: carBrand.text,
                  carModel: carModel.text,
                  firstName: firstName.text,
                  lastName: lastName.text,
                  telephoneNum: telephoneNum.text));
            }
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
