import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'EOptomizer',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'EOptomizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const frequencyChannel =
      MethodChannel('com.somdipdey.eoptomizer/frequency');
  bool optimizing = false;
  String bodyText = 'Not Optimizing';

  void _optimize() {
    setState(() {
      if (!optimizing) {
        print('Optimizing battery and thermal behaviour');
        setFrequencyLevelCPU0Max();
        setFrequencyLevelCPU4Max();
        setFrequencyLevelCPU6Max();
        setFrequencyLevelCPU0Min();
        setFrequencyLevelCPU4Min();
        setFrequencyLevelCPU6Min();
        //showSnackBar(context);
        optimizing = true;
        bodyText = 'Optimizing';
      } else {
        optimizing = false;
        bodyText = 'Not Optimizing';
        print('Not optimizing battery and thermal behaviour');
      }
    });
  }

  Future setFrequencyLevelCPU0Max() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU0Max');
    print('Optimizing CPU0 Max Frequency');
  }

  Future setFrequencyLevelCPU4Max() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU4Max');
    print('Optimizing CPU4 Max Frequency');
  }

  Future setFrequencyLevelCPU6Max() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU6Max');
    print('Optimizing CPU6 Max Frequency');
  }

  Future setFrequencyLevelCPU0Min() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU0Min');
    print('Optimizing CPU0 Min Frequency');
  }

  Future setFrequencyLevelCPU4Min() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU4Min');
    print('Optimizing CPU4 Min Frequency');
  }

  Future setFrequencyLevelCPU6Min() async {
    await frequencyChannel.invokeMethod('setFrequencyLevelCPU6Min');
    print('Optimizing CPU6 Min Frequency');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.deepPurple[600],
      ),
      backgroundColor: Colors.deepPurple[500],
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '$bodyText',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _optimize,
        tooltip: 'Start optimizing battery and thermal behaviour',
        child: new Icon(Icons.thumb_up),
        backgroundColor: Colors.deepPurple[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void showSnackBar(BuildContext context) {
  var snackBar =
      SnackBar(content: Text('Optimizing battery and thermal behaviour'));
  Scaffold.of(context).showSnackBar(snackBar);
}
