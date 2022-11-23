import 'package:flutter/material.dart';

class ScreenForClients extends StatefulWidget {
  const ScreenForClients({Key? key}) : super(key: key);

  @override
  State<ScreenForClients> createState() => _ScreenForClientsState();
}

class _ScreenForClientsState extends State<ScreenForClients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Second screen'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.lightGreen,
          )
        ],
      )),
    );
  }
}
