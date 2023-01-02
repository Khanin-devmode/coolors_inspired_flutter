import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class LibraryExplorePage extends StatelessWidget {
  const LibraryExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: 200,
            child: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Library',
                  // icon: Icon(Icons.cloud_outlined),
                ),
                Tab(
                  text: 'Explore',
                  // icon: Icon(Icons.beach_access_sharp),
                ),
              ],
            ),
          ),
        ),
        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text('Go back!'),
        //   ),
        // ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
