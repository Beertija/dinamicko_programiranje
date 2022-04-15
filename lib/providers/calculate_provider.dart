import 'package:dinamicko_programiranje/models/postava_zadatka.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  Map<int, String> privremeniIzracuni = {};

  PostavaZadatka _postavaZadatka = PostavaZadatka(
      rata: 0,
      max_nabava: 0,
      max_kapacitet: 0,
      trosak_nabave: 0,
      trosak_skladistenja: 0,
      razdoblja: {});

  PostavaZadatka get postavaZadatka => _postavaZadatka;

  void setup(
      double rata,
      double max_nabava,
      double max_kapacitet,
      double trosak_nabave,
      double trosak_skladistenja,
      Map<int, double> razdoblja) {
    _postavaZadatka = PostavaZadatka(
        rata: rata,
        max_nabava: max_nabava,
        max_kapacitet: max_kapacitet,
        trosak_nabave: trosak_nabave,
        trosak_skladistenja: trosak_skladistenja,
        razdoblja: razdoblja);
    kalkuliranjePocetnogTroska();
  }

  void kalkuliranjePocetnogTroska() {
    double zaliha = 0;
    int brojac = 1;
    for (double nabava = _postavaZadatka.razdoblja[1]!;
        nabava <=
            (_postavaZadatka.razdoblja[1]! + _postavaZadatka.max_kapacitet);
        nabava += _postavaZadatka.rata) {
      String izracun = "f(1)[" +
          zaliha.toString() +
          "] = [" +
          nabava.toString() +
          ", " +
          zaliha.toString() +
          "] = " +
          _postavaZadatka.trosak_nabave.toString() +
          " + " +
          (zaliha * _postavaZadatka.trosak_skladistenja).toString() +
          " = " +
          (_postavaZadatka.trosak_nabave +
                  (zaliha * _postavaZadatka.trosak_skladistenja))
              .toString();
      privremeniIzracuni.putIfAbsent(brojac, () => izracun);
      brojac++;
      zaliha += _postavaZadatka.rata;
    }
    notifyListeners();
  }

  // kalkuliranjeTroskaRazdoblja(int razdoblje) {
  //   int zaliha = 0;
  //   int nabava = zaliha + potrazivanja[razdoblje]! - maximalni_kapacitet;
  //   if (nabava < 0) {
  //     nabava = 0;
  //   }
  //   for (;
  //   nabava <= (potrazivanja[razdoblje]! + maximalni_kapacitet);
  //   nabava += rate) {
  //     privremeniIzracuni.add("[" +
  //         nabava.toString() +
  //         ", " +
  //         zaliha.toString() +
  //         "] + [" +
  //         zaliha.toString() +
  //         " - " +
  //         potrazivanja[razdoblje]!.toString() +
  //         " + " +
  //         nabava.toString() +
  //         "] = " +
  //         trosak_nabave.toString() +
  //         " + " +
  //         (zaliha * trosak_skladistenja).toString() +
  //         " = " +
  //         (trosak_nabave + (zaliha * trosak_skladistenja)).toString());
  //     zaliha += rate;
  //   }
  // }
}
