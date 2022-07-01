import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.deepPurple[500],
      appBar: AppBar(
        title: Text('EOptimizer'),
        backgroundColor: Colors.deepPurple[600],
      ),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ),
  ));
}

class CustomFAB extends StatefulWidget {
  static const frequencyChannel =
      MethodChannel('com.somdipdey.eoptomizer/frequency');

  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  String frequencyLevel = 'Waiting...';

  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          showSnackBar(context);

          print('Optimizing battery and thermal behaviour');
          setFrequencyLevel();
        },
        backgroundColor: Colors.deepPurple[900],
        icon: Icon(Icons.thumb_up),
        label: const Text('Optimize'),
        tooltip: 'Start optimizing battery and thermal behaviour');
  }

  Future setFrequencyLevel() async {
    await CustomFAB.frequencyChannel.invokeMethod('setFrequencyLevel');
  }
}

void showSnackBar(BuildContext context) {
  var snackBar =
      SnackBar(content: Text('Optimizing battery and thermal behaviour'));
  Scaffold.of(context).showSnackBar(snackBar);
}
