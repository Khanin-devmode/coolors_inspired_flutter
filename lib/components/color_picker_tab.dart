import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerTab extends ConsumerWidget {
  ColorPickerTab({
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

    return DefaultTabController(
      initialIndex: 0,
      length: 6, //
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
                      style: TextStyle(fontSize: 32),
                      maxLength: 9,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(kValidHexPattern))
                      ],
                      controller: hexTextController,
                      onChanged: (value) {
                        print(value.toUpperCase());
                        ref.read(hexTextControllerProvider.notifier).update(
                            (state) =>
                                TextEditingController(text: value.toString()));
                      },
                    ),
                  ),
                ),
                Center(
                  //HSL
                  child: SlidePicker(
                    showIndicator: false,
                    displayThumbColor: true,
                    sliderSize: Size(360, 40),
                    colorModel: ColorModel.hsl,
                    enableAlpha: false,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) => ref
                        .read(colorListProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
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
                        .read(colorListProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
                ),
                Center(
                  //MATERIAL
                  child: MaterialPicker(
                    portraitOnly: false,
                    pickerColor: colorList[activeIndex].color,
                    onColorChanged: ((value) => ref
                        .read(colorListProvider.notifier)
                        .pickColor(activeIndex, value)),
                  ),
                ),
                Center(
                  //SAVED
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in to view your colors',
                        style: kMutedLabel,
                      ),
                      TextButton(
                          onPressed: () => showSignInMenu(context, ref),
                          child: Text('Sign In'))
                    ],
                  ),
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
                  ref
                      .read(colorListProvider.notifier)
                      .update(previousColorList);
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
