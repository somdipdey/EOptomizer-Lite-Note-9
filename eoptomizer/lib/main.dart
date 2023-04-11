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
      title: 'EOptomizer Lite - Note 9',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'EOptomizer Lite - Note 9'),
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
  String FPSText = 'FPS: ';
  String LITTLEFreqSelected = "";
  String bigFreqSelected = "";
  String GPUFreqSelected = "";

  void _optimize() {
    setState(() {
      if (!optimizing) {
        optimizationOn();
        getFPS();
      } else {
        defaultScheduler();
        getFPS();
      }
    });
  }

  void optimizationOn() {
    debugPrint('Optimizing battery and thermal behaviour');
    setFrequencyLevelCPU0Max();
    setFrequencyLevelCPU4Max();
    setFrequencyLevelCPU0Min();
    setFrequencyLevelCPU4Min();
    setFrequencyLevelGPU();
    optimizing = true;
    bodyText = 'Optimization On';
  }

  void defaultScheduler() {
    debugPrint('Not optimizing battery and thermal behaviour');
    setDefaultFrequencyLevelCPU0Max();
    setDefaultFrequencyLevelCPU4Max();
    setDefaultFrequencyLevelCPU0Min();
    setDefaultFrequencyLevelCPU4Min();
    setDefaultFrequencyLevelGPU();
    optimizing = false;
    bodyText = 'Default';
  }

  Future getFPS() async {
    final String FPS = await frequencyChannel.invokeMethod('getFPS');
    debugPrint('Getting FPS');
    debugPrint(FPS);
    FPSText = 'FPS: ' + FPS;
    _FPS.text = FPSText;
  }

  // Functions to optimize frequencies for 2 CPU clusters
  Future setFrequencyLevelCPU0Max() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": LITTLEFreqSelected.toString().trim(),
      "bigCPUMaxFreq": bigFreqSelected.toString().trim(),
      "GPUFreq": GPUFreqSelected.toString().trim()
    };
    debugPrint(LITTLEFreqSelected.toString().trim());
    debugPrint(bigFreqSelected.toString().trim());
    final String frequencyLevelCPU0Max = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU0Max', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU0 Max Frequency');
    debugPrint(frequencyLevelCPU0Max);
  }

  Future setFrequencyLevelCPU4Max() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": LITTLEFreqSelected.toString().trim(),
      "bigCPUMaxFreq": bigFreqSelected.toString().trim(),
      "GPUFreq": GPUFreqSelected.toString().trim()
    };
    debugPrint(LITTLEFreqSelected.toString().trim());
    debugPrint(bigFreqSelected.toString().trim());
    final String frequencyLevelCPU4Max = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU4Max', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU4 Max Frequency');
    debugPrint(frequencyLevelCPU4Max);
  }

  Future setFrequencyLevelCPU0Min() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": LITTLEFreqSelected.toString().trim(),
      "bigCPUMaxFreq": bigFreqSelected.toString().trim(),
      "GPUFreq": GPUFreqSelected.toString().trim()
    };
    final String frequencyLevelCPU0Min = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU0Min', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU0 Min Frequency');
    debugPrint(frequencyLevelCPU0Min);
  }

  Future setFrequencyLevelCPU4Min() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": LITTLEFreqSelected.toString().trim(),
      "bigCPUMaxFreq": bigFreqSelected.toString().trim(),
      "GPUFreq": GPUFreqSelected.toString().trim()
    };
    final String frequencyLevelCPU4Min = await frequencyChannel.invokeMethod(
        'setFrequencyLevelCPU4Min', sendMapMaxCPUFreq);
    debugPrint('Optimizing CPU4 Min Frequency');
    debugPrint(frequencyLevelCPU4Min);
  }

  Future setFrequencyLevelGPU() async {
    var sendMapMaxCPUFreq = <String, String>{
      "LITTLECPUMaxFreq": LITTLEFreqSelected.toString().trim(),
      "bigCPUMaxFreq": bigFreqSelected.toString().trim(),
      "GPUFreq": GPUFreqSelected.toString().trim()
    };
    debugPrint(LITTLEFreqSelected.toString().trim());
    debugPrint(bigFreqSelected.toString().trim());
    debugPrint(GPUFreqSelected.toString().trim());
    final String frequencyLevelGPU = await frequencyChannel.invokeMethod(
        'setFrequencyLevelGPU', sendMapMaxCPUFreq);
    debugPrint('Optimizing GPU Frequency');
    debugPrint(frequencyLevelGPU);
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

  Future setDefaultFrequencyLevelGPU() async {
    final String frequencyLevelGPU =
        await frequencyChannel.invokeMethod('setDefaultFrequencyLevelGPU');
    debugPrint('Setting to default GPU Frequency');
    debugPrint(frequencyLevelGPU);
  }

  //////////////////////////////////////////////////

  //final _LITTLECPUFreq = TextEditingController()..text = "1794000";
  //final _bigCPUFreq = TextEditingController()..text = "1794000";
  //final _GPUFreq = TextEditingController()..text = "572000";
  final TextEditingController _FPS = TextEditingController();

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
            SizedBox(
              height: 20,
            ),
            new Text(
              "Selected LITTLE Freq",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            new DropdownButtonFormField(
                hint: Text("Select LITTLE Freq"),
                items: LITTLEFreqs.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  LITTLEFreqSelected = val;
                  debugPrint(LITTLEFreqSelected);
                }),
            //new TextField(
            //controller: _LITTLECPUFreq,
            //decoration: InputDecoration(
            //hintText: "LITTLE CPU Freq",
            //labelText: "LITTLE CPU Max Freq",
            //labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            //suffixIcon: IconButton(
            //onPressed: () {
            //_LITTLECPUFreq.clear();
            //},
            //icon: const Icon(Icons.clear),
            //),
            //),
            //),
            SizedBox(
              height: 15,
            ),
            new Text(
              "Selected big Freq",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            new DropdownButtonFormField(
                hint: Text("Select big Freq"),
                items: bigFreqs
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  bigFreqSelected = val;
                  debugPrint(bigFreqSelected);
                }),
            SizedBox(
              height: 15,
            ),
            new Text(
              "Selected GPU Freq",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            new DropdownButtonFormField(
                hint: Text("Select GPU Freq"),
                items: GPUFreqs.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  GPUFreqSelected = val;
                  debugPrint(GPUFreqSelected);
                }),
            /*
            SizedBox(
              height: 20,
            ),
            new TextField(
                controller: _FPS,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "FPS",
                  labelText: "FPS",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _FPS.clear();
                    },
                    icon: const Icon(Icons.adb_sharp),
                  ),
                )),
            */
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

List<String> LITTLEFreqs = [
  "1794000",
  "1690000",
  "1456000",
  "1248000",
  "1053000",
  "949000",
  "832000",
  "715000",
  "598000",
  "455000"
];

List<String> bigFreqs = [
  "1794000",
  "1690000",
  "1586000",
  "1469000",
  "1261000",
  "1170000",
  "1066000",
  "962000",
  "858000",
  "741000",
  "650000"
];

List<String> GPUFreqs = [
  "572000",
  "546000",
  "455000",
  "338000",
  "299000",
  "260000"
];
