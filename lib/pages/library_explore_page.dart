import 'package:coolors_inspired_flutter/logics/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryExplorePage extends ConsumerWidget {
  const LibraryExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPalettes = ref.watch(savedPaletteStream);
    final savedColor = ref.watch(savedColorStreamProvider);

    return DefaultTabController(
      initialIndex: 0,
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
                child: savedPalettes.when(
              data: (allPalettes) {
                return ListView.builder(
                  // Show messages from bottom to top
                  reverse: false,
                  itemCount: allPalettes.length,
                  itemBuilder: (context, index) {
                    ColorPaletteDoc colorPalette = allPalettes[index];
                    return Text(colorPalette.docId);
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            )),
            Center(
              child: savedColor.when(
                data: (allColors) {
                  return ListView.builder(
                    // Show messages from bottom to top
                    reverse: false,
                    itemCount: allColors.length,
                    itemBuilder: (context, index) {
                      ColorDoc color = allColors[index];
                      return Text(color.docId);
                    },
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
