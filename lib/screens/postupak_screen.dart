import 'package:flutter/material.dart';

class PostupakScreen extends StatelessWidget {
  const PostupakScreen({Key? key, required this.ispisProblemaPoRazdobljima})
      : super(key: key);
  final List<String> ispisProblemaPoRazdobljima;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text("Izračuni po razdobljima",
                style: TextStyle(color: Colors.white)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
                children: ispisProblemaPoRazdobljima
                    .map((String red) => Center(child: Text(red.toString(), textScaleFactor: 1.1,)))
                    .toList()),
          ),
        ));
  }
}
