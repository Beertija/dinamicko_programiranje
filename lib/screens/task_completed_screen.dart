import 'package:dinamicko_programiranje/components/razdoblje_card_template.dart';
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
          body: SingleChildScrollView(
            child: Column(
              children: const [
                //TODO napraviti kreiranje kartica s obzirom na kolicinu perioda
                RazdobljeCardTemplate(brRazdoblja: 1) //TODO proslijediti cijelu listu podataka razdoblja
                // Expanded(
                //     flex: 1,
                //     child: ListView.builder(
                //         itemCount:
                //             Provider.of<CalculateProvider>(context, listen: true)
                //                 .privremeniIzracuni
                //                 .length,
                //         itemBuilder: (context, index) {
                //           int key = Provider.of<CalculateProvider>(context,
                //                   listen: true)
                //               .privremeniIzracuni
                //               .keys
                //               .elementAt(index);
                //           return Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Text(Provider.of<CalculateProvider>(context,
                //                       listen: true)
                //                   .privremeniIzracuni[key]!),
                //             ],
                //           );
                //           // return Card(myDevice: PointsCalculator.Games[key]!);
                //         })),
              ],
            ),
          ),
        ));
  }
}
