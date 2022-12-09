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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ColorRow(
              color: Colors.red,
              colorCode: 'This is some color code',
            ),
            ColorRow(
              color: Colors.green,
              colorCode: 'This is some color code',
            ),
            ColorRow(
              color: Colors.blue,
              colorCode: 'This is some color code',
            ),
            ColorRow(
              color: Colors.brown,
              colorCode: 'This is some color code',
            ),
            ColorRow(
              color: Colors.yellow,
              colorCode: 'This is some color code',
            ),
          ],
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
