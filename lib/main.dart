import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ColorObj> ColorObjList = [
    ColorObj(Colors.red, getHexCode(Colors.red), false),
    ColorObj(Colors.green, getHexCode(Colors.green), false),
    ColorObj(Colors.blue, getHexCode(Colors.blue), false),
    ColorObj(Colors.yellow, getHexCode(Colors.yellow), false),
    ColorObj(Colors.purple, getHexCode(Colors.purple), false),
  ];

  void _generateColor() {
    RandomColor randomColor = RandomColor();
    ColorObjList.asMap().forEach((key, value) {
      if (!value.isLocked) {
        var newColor = randomColor.randomColor();
        setState(() {
          ColorObjList[key].color = newColor;
          ColorObjList[key].colorCode = getHexCode(newColor);
        });
      }
    });
  }

  void _toggleLock(ColorObj colorObj) {
    int index = ColorObjList.indexOf(colorObj);
    setState(() {
      ColorObjList[index].isLocked = !ColorObjList[index].isLocked;
    });
  }

  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _generateColor();
      },
      minimumShakeCount: 1,
      // shakeSlopTimeMS: 500,
      // shakeCountResetTime: 1000,
      shakeThresholdGravity: 1.5,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: ColorObjList.map((obj) => ColorRow(
                  colorObj: obj,
                  toggleLock: _toggleLock,
                )).toList(),
          ),
          bottomNavigationBar: Container(
            height: 60,
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () => _generateColor(),
                child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 50,
                    color: Colors.grey,
                    child: Text('Generate'))),
          )),
    );
  }
}

class ColorRow extends StatelessWidget {
  ColorRow({Key? key, required this.colorObj, required this.toggleLock})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: colorObj.color,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(colorObj.colorCode),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (() {
                  toggleLock(colorObj);
                }),
                child: Container(
                  child: colorObj.isLocked
                      ? const Icon(Icons.lock_outline)
                      : const Icon(Icons.lock_open),
                ),
              ))
        ]),
      ),
    );
  }
}

class ColorObj {
  ColorObj(this.color, this.colorCode, this.isLocked);

  Color color;
  String colorCode;
  bool isLocked;
}

String getHexCode(Color color) {
  return color.hashCode.toRadixString(16).substring(2).toUpperCase();
}
