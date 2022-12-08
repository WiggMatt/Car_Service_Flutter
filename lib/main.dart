import 'dart:io';
import 'package:car_service/data/repository/clients_repository_impl.dart';
import 'package:car_service/data/repository/contracts_repository_impl.dart';
import 'package:car_service/data/repository/mechanics_and_works_repository_impl.dart';
import 'package:car_service/domain/bloc/bloc_for_clients/client_bloc.dart';
import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/pages/clients_page.dart';
import 'package:car_service/presentation/pages/home_page.dart';
import 'package:car_service/presentation/pages/mechanics_and_works_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Автосервис WAGner');
    setWindowMinSize(const Size(1500.0, 800.0));
    setWindowMaxSize(Size.infinite);
  }
  runApp(BlocWrapper());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/clients': (context) => const ScreenForClients(),
        '/mechanics': (context) => const ScreenForMechanicsAndWorks(),
      },
    );
  }
}

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContractBloc>(
          create: (context) =>
              ContractBloc(repository: ContractsRepositoryImplementation())
                ..add(LoadingContractsTableEvent()),
        ),
        BlocProvider<ClientBloc>(
          create: (context) =>
              ClientBloc(repository: ClientsRepositoryImplementation())
                ..add(LoadingClientsTableEvent()),
        ),
        BlocProvider<MechanicsAndWorksBloc>(
            create: (context) => MechanicsAndWorksBloc(
                repository: MechanicsAndWorksRepositoryImplementation())
              ..add(LoadingMechanicsAndWorksTableEvent()))
      ],
      child: MyApp(),
    );
  }
}
