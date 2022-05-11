import 'package:dinamicko_programiranje/components/razdoblje_card_template.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';
import 'package:dinamicko_programiranje/screens/early_task_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({Key? key}) : super(key: key);

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Provider.of<CalculateProvider>(context, listen: false).reset();
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Problem nabave",
                style: TextStyle(color: Colors.white)),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Center(child: Text('Aplikacija za kolegij Operacijska Istraživanja 2',
                      textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white))),
                ),
                ListTile(
                  title: const Text('Raspisivanje početnog stanja'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const EarlyTaskCompletedScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: ListView.builder(
              itemCount: Provider.of<CalculateProvider>(context, listen: true)
                  .izracuniPoRazdobljima
                  .length,
              itemBuilder: (context, index) {
                List<List<PodaciRazdoblja>> liste =
                    Provider.of<CalculateProvider>(context, listen: true)
                        .izracuniPoRazdobljima
                        .values
                        .toList();
                return RazdobljeCardTemplate(
                    brRazdoblja: index + 1, podaciRazdoblja: liste[index]);
              }),
        ));
  }
}
