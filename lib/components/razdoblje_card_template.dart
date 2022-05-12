import 'package:dinamicko_programiranje/components/razdoblje_row_template.dart';
import 'package:dinamicko_programiranje/helpers/media_query.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RazdobljeCardTemplate extends StatelessWidget {
  const RazdobljeCardTemplate({Key? key, required this.brRazdoblja, required this.podaciRazdoblja}) : super(key: key);
  final int brRazdoblja;
  final List<PodaciRazdoblja> podaciRazdoblja;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: orientationMode(context) ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16) : const EdgeInsets.symmetric(vertical: 8, horizontal: 180),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
              child: Text(brRazdoblja.toString() + ". razdoblje",
                  textScaleFactor: 1.3),
              decoration: BoxDecoration(
                  color: Colors.orange[400],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: orientationMode(context) ? displayHeight(context) * 0.04 : displayHeight(context) * 0.08,
              alignment: Alignment.center),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [Text("Q(i)", textScaleFactor: 1.2), Text("f(i)", textScaleFactor: 1.2)],
          ),
          Column(
            children: podaciRazdoblja.map((PodaciRazdoblja red) => RazdobljeRowTemplate(podaci: red)).toList()
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
