import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/const/switch_style.dart';
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
  TextEditingController carBrand = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController stsNum = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController telephoneNum = TextEditingController();
  bool lightForBrandAndModel = false;
  bool lightForSTS = false;
  bool lightForReadiness = false;
  bool lightForPayment = false;
  var list;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is SearchedTableInitialState) {
          setState(() {
            list = state.searchedRows;
          });
        }
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: const Text('Поиск', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Switch(
                  value: lightForBrandAndModel,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                  onChanged: (bool value) {
                    setState(() {
                      lightForBrandAndModel = value;
                      if (lightForBrandAndModel) {
                        lightForReadiness = false;
                        lightForPayment = false;
                      } else {
                        carBrand.clear();
                        carModel.clear();
                      }
                    });
                  },
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        enabled: lightForBrandAndModel ? true : false,
                        maxLength: 10,
                        controller: carBrand,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[A-Z-a-z]"))
                        ],
                        decoration: const InputDecoration(
                          counter: Offstage(),
                          border: OutlineInputBorder(),
                          labelText: 'Марка авто',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        enabled: lightForBrandAndModel ? true : false,
                        maxLength: 10,
                        controller: carModel,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[A-Z-a-z-0-9]"))
                        ],
                        decoration: const InputDecoration(
                          counter: Offstage(),
                          border: OutlineInputBorder(),
                          labelText: 'Модель авто',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Switch(
                      value: lightForSTS,
                      overlayColor: overlayColor,
                      trackColor: trackColor,
                      thumbColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      onChanged: (bool value) {
                        setState(() {
                          lightForSTS = value;
                          if (lightForSTS) {
                            lightForReadiness = false;
                            lightForPayment = false;
                          } else {
                            stsNum.clear();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      enabled: lightForSTS ? true : false,
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
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: Row(
                children: [
                  Switch(
                    value: lightForBrandAndModel == true || lightForSTS == true
                        ? false
                        : lightForReadiness,
                    overlayColor: overlayColor,
                    trackColor: trackColor,
                    thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                    onChanged: (bool value) {
                      setState(() {
                        if (lightForBrandAndModel == true ||
                            lightForSTS == true) {
                          lightForReadiness = false;
                        } else {
                          lightForReadiness = value;
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 38),
                    child: Text('Работа выполнена',
                        style: TextStyle(
                            color: lightForReadiness
                                ? Colors.blue
                                : Colors.black38)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: Row(
                children: [
                  Switch(
                    value: lightForBrandAndModel == true || lightForSTS == true
                        ? false
                        : lightForPayment,
                    overlayColor: overlayColor,
                    trackColor: trackColor,
                    thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                    onChanged: (bool value) {
                      setState(() {
                        if (lightForBrandAndModel == true ||
                            lightForSTS == true) {
                          lightForPayment = false;
                        } else {
                          lightForPayment = value;
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 43),
                    child: Text('Работа оплачена',
                        style: TextStyle(
                            color: lightForPayment
                                ? Colors.blue
                                : Colors.black38)),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if ((carBrand.text.isEmpty && carModel.text.isEmpty) &&
                  stsNum.text.isEmpty &&
                  lightForSTS &&
                  lightForBrandAndModel) {
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
                            "Выберите значения!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      );
                    });
              } else {
                String payment = "";
                String readiness = "";
                if (lightForReadiness == true && lightForPayment == false) {
                  payment = "";
                  readiness = "Выполнено";
                } else if (lightForReadiness == false &&
                    lightForPayment == true) {
                  payment = "Оплачено";
                  readiness = "";
                } else if (lightForReadiness == true &&
                    lightForPayment == true) {
                  payment = "Оплачено";
                  readiness = "Выполнено";
                } else if (lightForBrandAndModel == true ||
                    lightForSTS == true) {
                  payment = "";
                  readiness = "";
                } else if (lightForBrandAndModel == false &&
                    lightForSTS == false) {
                  payment = "Не оплачено";
                  readiness = "В процессе";
                }

                widget.contractBloc.add(SearchContractEvent(
                    stsNum: stsNum.text,
                    carBrand: carBrand.text,
                    carModel: carModel.text,
                    readiness: readiness,
                    payment: payment));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchedContractsTableScreen(rows: list)));
              }
            },
            child: const Text('Найти'),
          ),
        ],
      ),
    );
  }
}
