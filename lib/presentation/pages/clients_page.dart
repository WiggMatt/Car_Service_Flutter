import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/widgets/controls_of_clients_table_widget.dart';
import 'package:car_service/presentation/widgets/table_clients_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenForClients extends StatefulWidget {
  const ScreenForClients({Key? key}) : super(key: key);

  @override
  State<ScreenForClients> createState() => _ScreenForClientsState();
}

class _ScreenForClientsState extends State<ScreenForClients> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ClientBloc>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          centerTitle: true,
          title: const Text('Клиенты'),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: ClientsTable(clientBloc: bloc)
                  ..clientBloc.add(LoadingClientsTableEvent())),
            const Expanded(flex: 2, child: ControlsOfClientsTable()),
          ],
        ));
  }
}
