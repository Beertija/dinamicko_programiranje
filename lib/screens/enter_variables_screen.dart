import 'package:dinamicko_programiranje/helpers/media_query.dart';
import 'package:flutter/material.dart';

class UnosVarijabliScreen extends StatefulWidget {
  const UnosVarijabliScreen({Key? key}) : super(key: key);

  @override
  State<UnosVarijabliScreen> createState() => _UnosVarijabliScreenState();
}

class _UnosVarijabliScreenState extends State<UnosVarijabliScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                      hintText: 'broj komada', labelText: 'Rata'),
                  validator: (value) {
                    return validateNumber(value);
                  },
                  // onSaved: (String value) {
                  //   _data.email = value;
                  // }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                      hintText: 'broj komada', labelText: 'Maksimalna nabava'),
                  validator: (value) {
                    return validateNumber(value);
                  },
                  // onSaved: (String value) {
                  //   _data.email = value;
                  // }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                      hintText: 'broj komada',
                      labelText: 'Maksimalni kapacitet'),
                  validator: (value) {
                    return validateNumber(value);
                  },
                  // onSaved: (String value) {
                  //   _data.email = value;
                  // }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                      hintText: 'broj', labelText: 'Trošak nabave'),
                  validator: (value) {
                    return validateNumber(value);
                  },
                  // onSaved: (String value) {
                  //   _data.email = value;
                  // }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                      hintText: 'broj', labelText: 'Trošak skladištenja'),
                  validator: (value) {
                    return validateNumber(value);
                  },
                  // onSaved: (String value) {
                  //   _data.email = value;
                  // }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'primjer: 20 40 20',
                      labelText: 'Broj razdoblja'),
                  validator: (value) {
                    return validateArray(value);
                  },
                  // onSaved: (double.parse(value)) {
                  //
                  // }
                ),
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
            int.parse(broj);
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
      try {
        int.parse(value);
        return null;
      } catch (FormatException) {
        return "Unesena stavka nije broj.";
      }
    }
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
