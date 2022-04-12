import 'package:flutter/material.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({Key? key}) : super(key: key);

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  int rate = 10;
  int maximalna_nabava = 70;
  int maximalni_kapacitet = 30;
  int trosak_skladistenja = 5;
  int trosak_nabave = 800;
  Map<int, int> potrazivanja = {1:40, 2:20, 3:30};
  List<String> privremeniIzracuni = <String>[];

  @override
  Widget build(BuildContext context) {
    kalkuliranjePocetnogTroska();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem nabave", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
                itemCount: privremeniIzracuni.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(privremeniIzracuni[index]),
                    ],
                  );
                  // return Card(myDevice: PointsCalculator.Games[key]!);
                })
          ),
        ],
      ),
    );
  }

  kalkuliranjePocetnogTroska(){
    int zaliha = 0;
    for (int nabava = potrazivanja[1]!; nabava <= (potrazivanja[1]! + maximalni_kapacitet); nabava += rate) {
      privremeniIzracuni.add("f(1)[" + zaliha.toString() + "] = [" + nabava.toString() + ", " + zaliha.toString() + "] = " + trosak_nabave.toString() + " + " + (zaliha * trosak_skladistenja).toString() + " = " + (trosak_nabave + (zaliha * trosak_skladistenja)).toString());
      zaliha += rate;
    }
  }

  kalkuliranjeTroskaRazdoblja(int razdoblje){
    int zaliha = 0;
    int nabava = zaliha + potrazivanja[razdoblje]! - maximalni_kapacitet;
    if (nabava < 0) {
      nabava = 0;
    }
    for (; nabava <= (potrazivanja[razdoblje]! + maximalni_kapacitet); nabava += rate) {
      privremeniIzracuni.add("[" + nabava.toString() + ", " + zaliha.toString() + "] + [" + zaliha.toString() + " - " + potrazivanja[razdoblje]!.toString() + " + " + nabava.toString() + "] = " + trosak_nabave.toString() + " + " + (zaliha * trosak_skladistenja).toString() + " = " + (trosak_nabave + (zaliha * trosak_skladistenja)).toString());
      zaliha += rate;
    }
  }
}
