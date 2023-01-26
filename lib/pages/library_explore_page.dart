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
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 36),
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
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
