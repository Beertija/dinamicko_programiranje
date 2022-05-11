import 'package:dinamicko_programiranje/helpers/utils.dart';
import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
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
            leading: GestureDetector(
                onTap: () {
                  Provider.of<CalculateProvider>(context, listen: false)
                      .reset(); //TODO remove when done
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Text("Raspisivanje početnog stanja",
                style: TextStyle(color: Colors.white)),
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
