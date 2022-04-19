import 'package:dinamicko_programiranje/helpers/media_query.dart';
import 'package:flutter/material.dart';

class RazdobljeCard extends StatelessWidget {
  const RazdobljeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
              child: Text("1. razdoblje",
                  textScaleFactor: 1.3),
              decoration: BoxDecoration(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: displayHeight(context) * 0.04,
              alignment: Alignment.center),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("f(i)", textScaleFactor: 1.2), Text("Q(i)", textScaleFactor: 1.2)],
          ),
          const Divider(indent: 40,
              endIndent: 40,
              thickness: 1,
              height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("20", textScaleFactor: 1.2), Text("400", textScaleFactor: 1.2)],
          ),
          const Divider(indent: 40,
              endIndent: 40,
              thickness: 1,
              height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("40", textScaleFactor: 1.2), Text("440", textScaleFactor: 1.2)],
          ),
          const Divider(indent: 40,
              endIndent: 40,
              thickness: 1,
              height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("60", textScaleFactor: 1.2), Text("480", textScaleFactor: 1.2)],
          )
        ],
      ),
    );
  }
}