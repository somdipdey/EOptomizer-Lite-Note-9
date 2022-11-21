import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EOptomizer - Pixel3',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'EOptomizer - Pixel3'),
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
  String bodyText = 'Default';

  void _optimize() {
    setState(() {
      if (!optimizing) {
        optimizationOn();
      } else {
        defaultScheduler();
      }
    });
  }

  void optimizationOn() {
    debugPrint('Optimizing battery and thermal behaviour');
    setFrequencyLevelCPU0Max();
    setFrequencyLevelCPU4Max();
    setFrequencyLevelCPU0Min();
    setFrequencyLevelCPU4Min();
    optimizing = true;
    bodyText = 'Optimization On';
  }

  void defaultScheduler() {
    debugPrint('Not optimizing battery and thermal behaviour');
    setDefaultFrequencyLevelCPU0Max();
    setDefaultFrequencyLevelCPU4Max();
    setDefaultFrequencyLevelCPU0Min();
    setDefaultFrequencyLevelCPU4Min();
    optimizing = false;
    bodyText = 'Default';
  }

  // Functions to optimize frequencies for 2 CPU clusters
  Future setFrequencyLevelCPU0Max() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": _LITTLECPUFreq.text.toString().trim(),
      "bigCPUMaxFreq": _bigCPUFreq.text.toString().trim()
    };
    debugPrint(_LITTLECPUFreq.text.toString().trim());
    debugPrint(_bigCPUFreq.text.toString().trim());
    final String frequencyLevelCPU0Max = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU0Max', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU0 Max Frequency');
    debugPrint(frequencyLevelCPU0Max);
  }

  Future setFrequencyLevelCPU4Max() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": _LITTLECPUFreq.text.toString().trim(),
      "bigCPUMaxFreq": _bigCPUFreq.text.toString().trim()
    };
    debugPrint(_LITTLECPUFreq.text.toString().trim());
    debugPrint(_bigCPUFreq.text.toString().trim());
    final String frequencyLevelCPU4Max = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU4Max', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU4 Max Frequency');
    debugPrint(frequencyLevelCPU4Max);
  }

  Future setFrequencyLevelCPU0Min() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": _LITTLECPUFreq.text,
      "bigCPUMaxFreq": _bigCPUFreq.text
    };
    final String frequencyLevelCPU0Min = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU0Min', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU0 Min Frequency');
    debugPrint(frequencyLevelCPU0Min);
  }

  Future setFrequencyLevelCPU4Min() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": _LITTLECPUFreq.text,
      "bigCPUMaxFreq": _bigCPUFreq.text
    };
    final String frequencyLevelCPU4Min = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU4Min', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU4 Min Frequency');
    debugPrint(frequencyLevelCPU4Min);
  }

  //Functions to set frequencies for 3 CPU clusters to default

  Future setDefaultFrequencyLevelCPU0Max() async {
    final String frequencyLevelCPU0Max =
        await frequencyChannel.invokeMethod('setDefaultFrequencyLevelCPU0Max');
    debugPrint('Setting to default CPU0 Max Frequency');
    debugPrint(frequencyLevelCPU0Max);
  }

  Future setDefaultFrequencyLevelCPU4Max() async {
    final String frequencyLevelCPU4Max =
        await frequencyChannel.invokeMethod('setDefaultFrequencyLevelCPU4Max');
    debugPrint('Setting to default CPU4 Max Frequency');
    debugPrint(frequencyLevelCPU4Max);
  }

  Future setDefaultFrequencyLevelCPU0Min() async {
    final String frequencyLevelCPU0Min =
        await frequencyChannel.invokeMethod('setDefaultFrequencyLevelCPU0Min');
    debugPrint('Setting to default CPU0 Min Frequency');
    debugPrint(frequencyLevelCPU0Min);
  }

  Future setDefaultFrequencyLevelCPU4Min() async {
    final String frequencyLevelCPU4Min =
        await frequencyChannel.invokeMethod('setDefaultFrequencyLevelCPU4Min');
    debugPrint('Setting to default CPU4 Min Frequency');
    debugPrint(frequencyLevelCPU4Min);
  }

  //////////////////////////////////////////////////

  final _LITTLECPUFreq = TextEditingController()..text = "1766400";
  final _bigCPUFreq = TextEditingController()..text = "2649600";

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
            new TextField(
              controller: _LITTLECPUFreq,
              decoration: InputDecoration(
                hintText: "LITTLE CPU Freq",
                labelText: "LITTLE CPU Max Freq",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                suffixIcon: IconButton(
                  onPressed: () {
                    _LITTLECPUFreq.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            new TextField(
              controller: _bigCPUFreq,
              decoration: InputDecoration(
                hintText: "big CPU Freq",
                labelText: "big CPU Max Freq",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                suffixIcon: IconButton(
                  onPressed: () {
                    _bigCPUFreq.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
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
