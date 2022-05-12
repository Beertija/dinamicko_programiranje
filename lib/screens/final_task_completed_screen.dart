import 'package:dinamicko_programiranje/helpers/utils.dart';
import 'package:dinamicko_programiranje/models/finalno_stanje.dart';
import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
import 'package:dinamicko_programiranje/screens/early_task_completed_screen.dart';
import 'package:dinamicko_programiranje/screens/task_completed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';

class FinalTaskCompletedScreen extends StatefulWidget {
  const FinalTaskCompletedScreen({Key? key}) : super(key: key);

  @override
  State<FinalTaskCompletedScreen> createState() =>
      _FinalTaskCompletedScreenState();
}

class _FinalTaskCompletedScreenState extends State<FinalTaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CalculateProvider>(context, listen: false)
            .reset();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Završna tablica",
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
                  title: const Text('Izračuni po razdobljima'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const TaskCompletedScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Završna tablica'),
                  onTap: () {
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
                  Text("Ukupan iznos: " +
                      Provider.of<CalculateProvider>(context, listen: true)
                          .ukupno.toString(),
                      textScaleFactor: 1.4),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text("Razdoblje", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("I(i-1)", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("Q(i)", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("D(i)", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("I(i)", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("Cp(i)", textScaleFactor: 1.1),
                            numeric: true),
                        DataColumn(
                            label: Text("Ch(i)", textScaleFactor: 1.1),
                            numeric: true),
                      ],
                      rows: getRows(
                          Provider.of<CalculateProvider>(context, listen: true)
                              .podaciFinalnogRacuna),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  getRows(List<FinalnoStanje> pocetnaPostava) =>
      pocetnaPostava.map((FinalnoStanje red) {
        final cells = [red.razdoblje, red.iProslo, red.q, red.d, red.iSada, red.cP, red.cH];
        return DataRow(
            cells: Utils.modelBuilder(cells, (index, cell) {
              return DataCell(Text('$cell', textScaleFactor: 1.2));
            }));
      }).toList();
}