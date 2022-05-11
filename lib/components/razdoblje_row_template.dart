import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:flutter/material.dart';

class RazdobljeRowTemplate extends StatelessWidget {
  const RazdobljeRowTemplate({Key? key, required this.podaci})
      : super(key: key);
  final PodaciRazdoblja podaci;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(indent: 40, endIndent: 40, thickness: 1, height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(podaci.q_i.toString(), textScaleFactor: 1.2),
          Text(podaci.f_i.toString(), textScaleFactor: 1.2),
        ])
      ],
    );
  }
}
