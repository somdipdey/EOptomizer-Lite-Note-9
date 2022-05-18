import 'package:flutter/material.dart';

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

class CustomFAB extends StatelessWidget {
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          showSnackBar(context);
          print('Optimizing battery and thermal behaviour');
        },
        backgroundColor: Colors.deepPurple[900],
        icon: Icon(Icons.thumb_up),
        label: const Text('Optimize'),
        tooltip: 'Start optimizing battery and thermal behaviour');
  }
}

void showSnackBar(BuildContext context) {
  var snackBar =
      SnackBar(content: Text('Optimizing battery and thermal behaviour'));
  Scaffold.of(context).showSnackBar(snackBar);
}
