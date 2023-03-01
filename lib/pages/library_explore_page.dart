import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:coolors_inspired_flutter/logics/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/pages/view_palette_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryExplorePage extends ConsumerWidget {
  const LibraryExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPalettes = ref.watch(savedPaletteStream);
    final explorePalettes = ref.watch(explorePaletteStream);
    final db = ref.watch(databaseProvider);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const SizedBox(
            width: 240,
            child: TabBar(
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
                child: savedPalettes.when(
              data: (allPalettes) {
                return ListView.builder(
                  // Show messages from bottom to top
                  reverse: false,
                  itemCount: allPalettes.length,
                  itemBuilder: (context, y) {
                    ColorPaletteDoc colorPalette = allPalettes[y];
                    List<Color> colors = colorPalette.colors;
                    return PaletteDisplay(
                      index: y + 1,
                      db: db,
                      colorPalette: colorPalette,
                      colors: colors,
                      deleteable: true,
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            )),
            Center(
                child: explorePalettes.when(
              data: (allPalettes) {
                return ListView.builder(
                  // Show messages from bottom to top
                  reverse: false,
                  itemCount: allPalettes.length,
                  itemBuilder: (context, y) {
                    ColorPaletteDoc colorPalette = allPalettes[y];
                    List<Color> colors = colorPalette.colors;
                    return PaletteDisplay(
                      index: y + 1,
                      db: db,
                      colorPalette: colorPalette,
                      colors: colors,
                      deleteable: false,
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            )),
          ],
        ),
      ),
    );
  }
}

class PaletteDisplay extends ConsumerWidget {
  const PaletteDisplay(
      {super.key,
      required this.db,
      required this.colorPalette,
      required this.colors,
      required this.deleteable,
      required this.index});

  final Database db;
  final ColorPaletteDoc colorPalette;
  final List<Color> colors;
  final bool deleteable;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Palette $index'),
              deleteable
                  ? IconButton(
                      iconSize: 16,
                      onPressed: () {
                        db.deleteSavedPalette(colorPalette.docId, () {
                          showSnackBar(context, 'Palette deleted');
                        });
                      },
                      icon: const Icon(Icons.close))
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(width: 24, height: 24),
                    )
            ],
          ),
          GestureDetector(
            onTap: () {
              ref.read(viewingPaletteProvider.notifier).update((state) => colors
                  .map((value) => ColorObj(value, getHexCode(value), false))
                  .toList());
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return const ViewPalettePage();
                  },
                ),
              );
            },
            child: Row(
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
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8))
                            : x == colors.length - 1
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))
                                : const BorderRadius.all(Radius.zero)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
