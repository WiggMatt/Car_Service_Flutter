import 'package:car_service/domain/bloc/bloc_for_mechanics_and_works/mechanics_and_works_bloc.dart';
import 'package:car_service/presentation/widgets/controls_of_mech_and_works_widget.dart';
import 'package:car_service/presentation/widgets/table_mechanics_and_works_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenForMechanicsAndWorks extends StatefulWidget {
  const ScreenForMechanicsAndWorks({Key? key}) : super(key: key);

  @override
  State<ScreenForMechanicsAndWorks> createState() =>
      _ScreenForMechanicsAndWorksState();
}

class _ScreenForMechanicsAndWorksState
    extends State<ScreenForMechanicsAndWorks> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MechanicsAndWorksBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Механики'),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: MechanicsAndWorksTable(mechanicsAndWorksBloc: bloc)
                  ..mechanicsAndWorksBloc
                      .add(LoadingMechanicsAndWorksTableEvent())),
            const Expanded(flex: 2, child: ControlsOfMechanicsAndWorkTable()),
          ],
        ));
  }
}
