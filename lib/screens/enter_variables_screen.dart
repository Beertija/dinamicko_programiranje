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
        title: const Text("Problem nabave", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                    decoration: const InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address'
                    ),
                    // validator: _validateEmail,
                    // onSaved: (String value) {
                    //   _data.email = value;
                    // }
                ),
                TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password'
                    ),
                    // validator: this._validatePassword,
                    // onSaved: (double.parse(value)) {
                    //
                    // }
                ),
                Container(
                  width: displayWidth(context),
                  child: RaisedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: submit,
                    color: Colors.blue,
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
