import 'package:flutter/material.dart';

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
    ColorObj(Colors.red, 'Color 1 Hex Code'),
    ColorObj(Colors.green, 'Color 2 Hex Code'),
    ColorObj(Colors.blue, 'Color 3 Hex Code'),
    ColorObj(Colors.yellow, 'Color 4 Hex Code'),
    ColorObj(Colors.purple, 'Color 5 Hex Code'),
  ];

  void _generateColor() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: ColorObjList.map(
                  (e) => new ColorRow(color: e.color, colorCode: e.colorCode))
              .toList(),
        ),
        bottomNavigationBar:
            BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ]),
      ),
    );
  }
}

class ColorRow extends StatelessWidget {
  ColorRow({Key? key, required this.color, required this.colorCode})
      : super(key: key);

  Color color;
  String colorCode;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: color,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(colorCode),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.lock),
          )
        ]),
      ),
    );
  }
}

class ColorObj {
  ColorObj(this.color, this.colorCode);

  Color color;
  String colorCode;
}
