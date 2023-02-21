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
    final db = ref.watch(databaseProvider);

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
                  itemBuilder: (context, y) {
                    ColorPaletteDoc colorPalette = allPalettes[y];
                    List<Color> colors = colorPalette.colors;
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Palette ${y + 1}'),
                              IconButton(
                                  iconSize: 16,
                                  onPressed: () {
                                    db.deleteSavedPalette(
                                        colorPalette.docId, () {});
                                  },
                                  icon: Icon(Icons.close))
                            ],
                          ),
                          Row(
                            children: List.generate(
                              colors.length,
                              (x) => Expanded(
                                flex: 1,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: colors[x],
                                      borderRadius: x == 0
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8))
                                          : x == colors.length - 1
                                              ? BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8))
                                              : BorderRadius.all(Radius.zero)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            )),
            Center(child: Text('Explore Page')),
          ],
        ),
      ),
    );
  }
}
