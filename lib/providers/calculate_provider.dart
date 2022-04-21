import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/models/postava_zadatka.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  Map<int, String> privremeniIzracuni = {};
  List<PocetnoStanje> pocetnaPostava = [];
  List<PodaciRazdoblja> podaciRazdoblja = [];
  String postavaPocetka = "";
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
    podaciRazdoblja = [];
    pocetnaPostava = [];
    postavaPocetka = "";
    brojac = 1;
    brojacPostave = 1;
  }

  void setup(int rata, int max_nabava, int max_kapacitet, int trosak_nabave,
      int trosak_skladistenja, Map<int, int> razdoblja) {
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

  int racunanjePostaveZadatka() {
    int zaliha = 0;
    postavaPocetka = zaliha.toString() +
        " ≤ nabava(i) ≤ " +
        _postavaZadatka.max_kapacitet.toString();
    for (int i = 0;
        i <= _postavaZadatka.max_kapacitet;
        i += _postavaZadatka.rata) {
      pocetnaPostava.add(PocetnoStanje(brojac: brojacPostave, nabava: i));
      brojacPostave++;
    }
    return zaliha;
  }

  void kalkuliranjePocetnogTroska() {
    int zaliha = racunanjePostaveZadatka();
    for (int nabava = _postavaZadatka.razdoblja[1]!;
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
      podaciRazdoblja.add(PodaciRazdoblja(f_i: zaliha, q_i: (_postavaZadatka.trosak_nabave +
          (zaliha * _postavaZadatka.trosak_skladistenja))));
      brojac++;
      zaliha += _postavaZadatka.rata;
    }
    notifyListeners();
  }

  kalkuliranjeTroskaRazdoblja(int razdoblje) {
    //TODO Popraviti ispis metode te način iteriranja kroz razdoblja - big task
    double zaliha = 0;
    double nabava = zaliha +
        _postavaZadatka.razdoblja[razdoblje]! -
        _postavaZadatka.max_kapacitet;
    if (nabava < 0) {
      nabava = 0;
    }
    for (;
        nabava <=
            (_postavaZadatka.razdoblja[razdoblje]! +
                _postavaZadatka.max_kapacitet);
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
          (_postavaZadatka.trosak_nabave +
                  (zaliha * _postavaZadatka.trosak_skladistenja))
              .toString();
      privremeniIzracuni.putIfAbsent(brojac, () => zapis);
      brojac++;
      zaliha += _postavaZadatka.rata;
    }
  }
}
