import 'package:dinamicko_programiranje/models/postava_zadatka.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  Map<int, String> privremeniIzracuni = {};
  Map<int, String> pocetnaPostava = {};
  Map<int, int> f_i = {};
  Map<int, int> q_i = {};
  int brojac = 1;
  int brojacPostave = 1;

  PostavaZadatka _postavaZadatka = PostavaZadatka(
      rata: 0,
      max_nabava: 0,
      max_kapacitet: 0,
      trosak_nabave: 0,
      trosak_skladistenja: 0,
      razdoblja: {});

  PostavaZadatka get postavaZadatka => _postavaZadatka;

  void reset() {
    _postavaZadatka = PostavaZadatka(
        rata: 0,
        max_nabava: 0,
        max_kapacitet: 0,
        trosak_nabave: 0,
        trosak_skladistenja: 0,
        razdoblja: {});
    privremeniIzracuni = {};
    pocetnaPostava = {};
    f_i = {};
    q_i = {};
    brojac = 1;
    brojacPostave = 1;
  }

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
    // for (int br = 2; br <= _postavaZadatka.razdoblja.length; br++) {
    //   kalkuliranjeTroskaRazdoblja(br);
    // }
  }

  void kalkuliranjePocetnogTroska() {
    //TODO razdvojiti prvi dio od prvog razdoblja u zasebne metode i napraviti zasebnu karticu za prikaz posto nema postupaka
    double zaliha = 0;
    String postava = zaliha.toString() + " ≤ nabava(i) ≤ " + _postavaZadatka.max_kapacitet.toString();
    pocetnaPostava.putIfAbsent(brojacPostave, () => postava);
    brojacPostave++;
    for (double i = 0; i <= _postavaZadatka.max_kapacitet; i += _postavaZadatka.rata) {
      String zapis = "I(" + (brojacPostave - 1).toString() + ") = " + i.toString();
      pocetnaPostava.putIfAbsent(brojacPostave, () => zapis);
      brojacPostave++;
    }
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
      f_i.putIfAbsent(brojac, () => zaliha.toInt());
      q_i.putIfAbsent(brojac, () => (_postavaZadatka.trosak_nabave +
          (zaliha * _postavaZadatka.trosak_skladistenja)).toInt());
      brojac++;
      zaliha += _postavaZadatka.rata;
    }
    notifyListeners();
  }

  kalkuliranjeTroskaRazdoblja(int razdoblje) {
    //TODO Popraviti ispis metode te način iteriranja kroz razdoblja - big task
    double zaliha = 0;
    double nabava = zaliha + _postavaZadatka.razdoblja[razdoblje]! - _postavaZadatka.max_kapacitet;
    if (nabava < 0) {
      nabava = 0;
    }
    for (;
    nabava <= (_postavaZadatka.razdoblja[razdoblje]! + _postavaZadatka.max_kapacitet);
    nabava += _postavaZadatka.rata) {
      String zapis = "[" +
          nabava.toString() +
          ", " +
          zaliha.toString() +
          "] + [" +
          zaliha.toString() +
          " - " +
          _postavaZadatka.razdoblja[razdoblje]!.toString() +
          " + " +
          nabava.toString() +
          "] = " +
          _postavaZadatka.trosak_nabave.toString() +
          " + " +
          (zaliha * _postavaZadatka.trosak_skladistenja).toString() +
          " = " +
          (_postavaZadatka.trosak_nabave + (zaliha * _postavaZadatka.trosak_skladistenja)).toString();
      privremeniIzracuni.putIfAbsent(brojac, () => zapis);
      brojac++;
      zaliha += _postavaZadatka.rata;
    }
  }
}
