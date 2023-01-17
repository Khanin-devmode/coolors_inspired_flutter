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
            padding: EdgeInsets.only(top: 28),
            height: 284,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
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
                        BorderRadius.all(Radius.circular(12)),
                    paletteType: PaletteType.hsl,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) => ref
                        .read(colorObjProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
                ),
                Center(
                  //HEX
                  child: Text("2"),
                ),
                Center(
                  //HSB
                  child: Text("3"),
                ),
                Center(
                  //HSL
                  child: Text("4"),
                ),
                Center(
                    //RGB
                    child: SlidePicker(
                  showIndicator: false,
                  displayThumbColor: true,
                  sliderSize: Size(360, 40),
                  colorModel: ColorModel.rgb,
                  enableAlpha: false,
                  pickerColor: colorList[activeIndex].color,
                  onColorChanged: ((value) => ref
                      .read(colorObjProvider.notifier)
                      .pickColor(activeIndex, value)),
                )),
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
