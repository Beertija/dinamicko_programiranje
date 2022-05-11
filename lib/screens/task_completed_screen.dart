import 'package:dinamicko_programiranje/components/razdoblje_card_template.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';
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
            leading: GestureDetector(
                onTap: () {
                  Provider.of<CalculateProvider>(context, listen: false)
                      .reset();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Text("Problem nabave",
                style: TextStyle(color: Colors.white)),
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
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
