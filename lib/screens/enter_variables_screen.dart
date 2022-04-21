import 'package:dinamicko_programiranje/helpers/media_query.dart';
import 'package:dinamicko_programiranje/providers/calculate_provider.dart';
import 'package:dinamicko_programiranje/screens/early_task_completed_screen.dart';
import 'package:dinamicko_programiranje/screens/task_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnosVarijabliScreen extends StatefulWidget {
  const UnosVarijabliScreen({Key? key}) : super(key: key);

  @override
  State<UnosVarijabliScreen> createState() => _UnosVarijabliScreenState();
}

class _UnosVarijabliScreenState extends State<UnosVarijabliScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int rata;
  late int max_nabava;
  late int max_kapacitet;
  late int trosak_nabave;
  late int trosak_skladistenja;
  late Map<int, int> razdoblja;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Problem nabave", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'broj komada', labelText: 'Rata'),
                    validator: (value) {
                      return validateNumber(value);
                    },
                    onSaved: (value) {
                      save(value, 1);
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'broj komada',
                        labelText: 'Maksimalna nabava'),
                    validator: (value) {
                      return validateNumber(value);
                    },
                    onSaved: (value) {
                      save(value, 2);
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'broj komada',
                        labelText: 'Maksimalni kapacitet'),
                    validator: (value) {
                      return validateNumber(value);
                    },
                    onSaved: (value) {
                      save(value, 3);
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'broj', labelText: 'Trošak nabave'),
                    validator: (value) {
                      return validateNumber(value);
                    },
                    onSaved: (value) {
                      save(value, 4);
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'broj', labelText: 'Trošak skladištenja'),
                    validator: (value) {
                      return validateNumber(value);
                    },
                    onSaved: (value) {
                      save(value, 5);
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'primjer: 20 40 20',
                        labelText: 'Broj razdoblja'),
                    validator: (value) {
                      return validateArray(value);
                    },
                    onSaved: (value) {
                      save(value, 6);
                    }),
                Container(
                  width: displayWidth(context),
                  child: ElevatedButton(
                    child: const Text(
                      'Izračunaj',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: submit,
                  ),
                  margin: const EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          )),
    );
  }

  String? validateArray(String? value) {
    if (value == null || value.isEmpty) {
      return "Unesite broj!";
    } else {
      List<String> lista = value.split(" ");
      try {
        for (String broj in lista) {
          if (broj != "") {
            double.parse(broj);
          }
        }
        return null;
      } catch (FormatException) {
        return "Unesena stavka nije broj.";
      }
    }
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Unesite broj!";
    } else {
      List<String> lista = value.split(" ");
      if (lista.length > 1) return "Traži se samo jedan broj.";
      try {
        double.parse(value);
        return null;
      } catch (FormatException) {
        return "Unesena stavka nije broj.";
      }
    }
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<CalculateProvider>(context, listen: false).setup(
          rata,
          max_nabava,
          max_kapacitet,
          trosak_nabave,
          trosak_skladistenja,
          razdoblja);
      openTaskCompletedScreen();
    }
  }

  Future<void> openTaskCompletedScreen() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EarlyTaskCompletedScreen()));
  }

  save(String? value, int option) {
    switch (option) {
      case 1:
        rata = int.parse(value!);
        break;
      case 2:
        max_nabava = int.parse(value!);
        break;
      case 3:
        max_kapacitet = int.parse(value!);
        break;
      case 4:
        trosak_nabave = int.parse(value!);
        break;
      case 5:
        trosak_skladistenja = int.parse(value!);
        break;
      case 6:
        razdoblja = {};
        List<String> lista = value!.split(" ");
        int brojac = 1;
        for (String broj in lista) {
          if (broj != "") {
            razdoblja.putIfAbsent(brojac, () => int.parse(broj));
            brojac++;
          }
        }
        break;
    }
  }
}