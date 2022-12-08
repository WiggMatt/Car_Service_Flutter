import 'package:car_service/presentation/const/button_styles.dart';
import 'package:car_service/presentation/pages/clients_page.dart';
import 'package:car_service/presentation/pages/mechanics_and_works_page.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        const SizedBox(
          height: 80,
          child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                  child: Text("Меню",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 2,
                      )))),
        ),
        ListTile(
          title: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/clients');
              },
              child: const Text('Таблица с клиентами')),
        ),
        ListTile(
          title: ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/mechanics');
              },
              child: const Text('Таблица с механиками')),
        ),
      ],
    ));
  }
}
