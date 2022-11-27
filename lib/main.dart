import 'dart:io';
import 'package:car_service/data/repository/tables_repository_impl.dart';
import 'package:car_service/domain/bloc/contract_bloc.dart';
import 'package:car_service/presentation/pages/home_page.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContractBloc>(
      create: (context) =>
          ContractBloc(repository: TablesRepositoryImplementation())
            ..add(LoadingContractsTableEvent()),
      child: MyApp(),
    );
  }
}
