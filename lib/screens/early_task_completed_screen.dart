import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';

class EarlyTaskCompletedScreen extends StatefulWidget {
  const EarlyTaskCompletedScreen({Key? key}) : super(key: key);

  @override
  State<EarlyTaskCompletedScreen> createState() => _EarlyTaskCompletedScreenState();
}

class _EarlyTaskCompletedScreenState extends State<EarlyTaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Navigator.pop(context);
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text("Raspisivanje početnog stanja",
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView( //TODO DataTable
          child: ListView.builder(
              itemCount:
              Provider.of<CalculateProvider>(context, listen: true) // TODO sada imam mape za podatke
                  .f_i
                  .length,
              itemBuilder: (context, index) {
                int key = Provider.of<CalculateProvider>(context,
                    listen: true)
                    .f_i
                    .keys
                    .elementAt(index);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(Provider.of<CalculateProvider>(context,
                        listen: true)
                        .f_i[key].toString()),
                    Text(Provider.of<CalculateProvider>(context,
                        listen: true)
                        .q_i[key].toString()),
                  ],
                );
                // return Card(myDevice: PointsCalculator.Games[key]!);
              })
      ),
    ),);
  }
}
