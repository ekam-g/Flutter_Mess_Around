// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Proggy extends StatelessWidget {
  const Proggy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Work in Progess"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'This is just a cool widget so add stuff here',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
