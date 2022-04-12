import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {

  int rate = 10;
  int maximalna_nabava = 70;
  int maximalni_kapacitet = 30;
  int trosak_skladistenja = 5;
  int trosak_nabave = 800;
  Map<int, int> potrazivanja = {1:40, 2:20, 3:30};
  List<String> privremeniIzracuni = <String>[];

  PodaciRazdoblja _podaciRazdoblja =
      PodaciRazdoblja(ukupniTrosakProcesaNabave: [], nabavaRazdoblja: []);

  PodaciRazdoblja get podaciRazdoblja => _podaciRazdoblja;

  void reset() {
    _podaciRazdoblja =
        PodaciRazdoblja(ukupniTrosakProcesaNabave: [], nabavaRazdoblja: []);
  }

  void kalkuliranjePocetnogTroska() {
    int zaliha = 0;
    for (int nabava = potrazivanja[1]!; nabava <= (potrazivanja[1]! + maximalni_kapacitet); nabava += rate) {
      privremeniIzracuni.add("f(1)[" + zaliha.toString() + "] = [" + nabava.toString() + ", " + zaliha.toString() + "] = " + trosak_nabave.toString() + " + " + (zaliha * trosak_skladistenja).toString() + " = " + (trosak_nabave + (zaliha * trosak_skladistenja)).toString());
      zaliha += rate;
    }
    notifyListeners();
  }
}
