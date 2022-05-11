import 'package:dinamicko_programiranje/helpers/utils.dart';
import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
import 'package:dinamicko_programiranje/screens/task_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';

class EarlyTaskCompletedScreen extends StatefulWidget {
  const EarlyTaskCompletedScreen({Key? key}) : super(key: key);

  @override
  State<EarlyTaskCompletedScreen> createState() =>
      _EarlyTaskCompletedScreenState();
}

class _EarlyTaskCompletedScreenState extends State<EarlyTaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CalculateProvider>(context, listen: false)
            .reset(); //TODO remove when done
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Raspisivanje početnog stanja",
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
                  title: const Text('Problem nabave'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const TaskCompletedScreen()));
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
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                      Provider.of<CalculateProvider>(context, listen: true)
                          .postavaPocetka,
                      textScaleFactor: 1.4),
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text("Mogućnosti", textScaleFactor: 1.1),
                          numeric: true),
                      DataColumn(
                          label: Text("Količina nabave I(i)", textScaleFactor: 1.1),
                          numeric: true),
                    ],
                    rows: getRows(
                        Provider.of<CalculateProvider>(context, listen: true)
                            .pocetnaPostavaTablice),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  getRows(List<PocetnoStanje> pocetnaPostava) =>
      pocetnaPostava.map((PocetnoStanje red) {
        final cells = [red.brojac, red.nabava];
        return DataRow(
            cells: Utils.modelBuilder(cells, (index, cell) {
          return DataCell(Text('$cell', textScaleFactor: 1.2));
        }));
      }).toList();
}
