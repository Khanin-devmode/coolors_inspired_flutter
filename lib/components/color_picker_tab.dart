import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
    return DefaultTabController(
      initialIndex: 0,
      length: 7, //
      child: Column(
        children: [
          TabBar(
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
                text: 'HSB',
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
                text: 'CMYK',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'SAVED',
                // icon: Icon(Icons.beach_access_sharp),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 340,
            child: TabBarView(
              children: <Widget>[
                Center(
                  child: ColorPicker(
                    displayThumbColor: true,
                    enableAlpha: false,
                    showLabel: false,
                    colorPickerWidth: 350,
                    pickerAreaHeightPercent: 0.7,
                    pickerAreaBorderRadius:
                        BorderRadius.all(Radius.circular(12)),
                    paletteType: PaletteType.hsl,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) => ref
                        .read(colorObjProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
                ),
                Center(
                  child: Text("2"),
                ),
                Center(
                  child: Text("3"),
                ),
                Center(
                  child: Text("4"),
                ),
                Center(
                  child: Text("5"),
                ),
                Center(
                  child: Text("6"),
                ),
                Center(
                  child: Text("7"),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (() {
                  ref
                      .read(isPickingColorProvider.notifier)
                      .update((state) => !state);
                  ref.read(colorObjProvider.notifier).update(previousColorList);
                }),
                child: Text(
                  'Cancel',
                  style: kGenLabel,
                ),
              ),
              TextButton(
                onPressed: (() => ref
                    .read(isPickingColorProvider.notifier)
                    .update((state) => !state)),
                child: Text(
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
