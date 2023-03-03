import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/logics/auth_logic.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/logics/db_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tinycolor2/tinycolor2.dart';

class ColorPickerTab extends ConsumerWidget {
  const ColorPickerTab({
    Key? key,
    required this.colorList,
    required this.activeIndex,
    required this.previousColorList,
  }) : super(key: key);

  final List<ColorObj> colorList;
  final int activeIndex;
  final List<ColorObj> previousColorList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController hexTextController =
        ref.watch(hexTextControllerProvider);

    final userSavedColors = ref.watch(savedColorStreamProvider);

    final user = ref.watch(authStateProvider).value;

    final ColorListNotifier colorlistNofifier =
        ref.read(colorListProvider.notifier);

    final db = ref.watch(databaseProvider);

    return DefaultTabController(
      initialIndex: 0,
      length: 6, //
      child: Column(
        children: [
          const TabBar(
            isScrollable: true,
            labelColor: kDarkLabelClr,
            tabs: <Widget>[
              Tab(
                text: 'Picker',
                // icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                text: 'HEX',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'HSL',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'RGB',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'MATERIAL',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'SAVED',
                // icon: Icon(Icons.beach_access_sharp),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 28),
            height: 284,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Center(
                  //Picker
                  child: ColorPicker(
                    displayThumbColor: true,
                    enableAlpha: false,
                    showLabel: false,
                    colorPickerWidth: 350,
                    pickerAreaHeightPercent: 0.5,
                    pickerAreaBorderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                    paletteType: PaletteType.hsv,
                    hexInputController: hexTextController,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) => ref
                        .read(colorListProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
                ),
                Center(
                  //HEX
                  child: SizedBox(
                    width: 280,
                    height: 48,
                    child: CupertinoTextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 32),
                      maxLength: 6,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(kValidHexPattern))
                      ],
                      controller: hexTextController,
                      onChanged: (value) {
                        // print(value.toUpperCase());
                        // ref.read(hexTextControllerProvider.notifier).update(
                        //     (state) =>
                        //         TextEditingController(text: value.toString()));
                        int hexCode = int.parse('0xff${value.toString()}');
                        Color newColor = Color(hexCode);
                        ref
                            .read(colorListProvider.notifier)
                            .pickColor(activeIndex, newColor);
                      },
                    ),
                  ),
                ),
                Center(
                  //HSL
                  child: SlidePicker(
                    showIndicator: false,
                    displayThumbColor: true,
                    sliderSize: const Size(360, 40),
                    colorModel: ColorModel.hsl,
                    enableAlpha: false,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) {
                      ref
                          .read(colorListProvider.notifier)
                          .pickColor(activeIndex, value);
                      ref.read(hexTextControllerProvider.notifier).update(
                          (state) =>
                              TextEditingController(text: getHexCode(value)));
                    }),
                  ),
                ),
                Center(
                  //RGB
                  child: SlidePicker(
                    showIndicator: false,
                    displayThumbColor: true,
                    sliderSize: const Size(360, 40),
                    colorModel: ColorModel.rgb,
                    enableAlpha: false,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) {
                      ref
                          .read(colorListProvider.notifier)
                          .pickColor(activeIndex, value);
                      ref.read(hexTextControllerProvider.notifier).update(
                          (state) =>
                              TextEditingController(text: getHexCode(value)));
                    }),
                  ),
                ),
                Center(
                  //MATERIAL
                  child: MaterialPicker(
                    portraitOnly: false,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) {
                      ref
                          .read(colorListProvider.notifier)
                          .pickColor(activeIndex, value);
                      ref.read(hexTextControllerProvider.notifier).update(
                          (state) =>
                              TextEditingController(text: getHexCode(value)));
                    }),
                  ),
                ),
                Center(
                  //SAVED
                  child: user == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sign in to view your colors',
                              style: kMutedLabel,
                            ),
                            TextButton(
                                onPressed: () => showSignInMenu(context, ref),
                                child: const Text('Sign In'))
                          ],
                        )
                      : userSavedColors.when(
                          data: (allColors) {
                            if (allColors.isNotEmpty) {
                              return ListView.builder(
                                // Show messages from bottom to top
                                reverse: false,
                                itemCount: allColors.length,
                                itemBuilder: (context, index) {
                                  ColorDoc color = allColors[index];
                                  return SavedColorRow(
                                      color: color.color,
                                      notifier: colorlistNofifier,
                                      activeIndex: activeIndex,
                                      docId: color.docId,
                                      db: db);
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text(
                                      "Your saved colors will be shown here."));
                            }
                          },
                          error: (error, stackTrace) => Text(error.toString()),
                          loading: () => const CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (() {
                  ref
                      .read(isPickingColorProvider.notifier)
                      .update((state) => !state);
                  ref
                      .read(colorListProvider.notifier)
                      .update(previousColorList);
                }),
                child: const Text(
                  'Cancel',
                  style: kGenLabel,
                ),
              ),
              TextButton(
                onPressed: (() => ref
                    .read(isPickingColorProvider.notifier)
                    .update((state) => !state)),
                child: const Text(
                  'Apply',
                  style: kGenLabel,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SavedColorRow extends StatelessWidget {
  const SavedColorRow(
      {super.key,
      required this.color,
      required this.notifier,
      required this.activeIndex,
      required this.docId,
      required this.db});

  final Color color;
  final ColorListNotifier notifier;
  final int activeIndex;
  final String docId;
  final Database db;

  @override
  Widget build(BuildContext context) {
    Color textColor = color.isLight ? kDarkLabelClr : kWhiteLabelClr;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: textColor,
                    size: 16,
                  ),
                  onPressed: () {
                    db.deleteSavedColor(docId, () {
                      showSnackBar(context, 'Color deleted');
                    });
                  },
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    notifier.pickColor(activeIndex, color);
                  },
                  child: SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        getHexCode(color),
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 36,
                ),
              ],
            ),
          )),
    );
  }
}
