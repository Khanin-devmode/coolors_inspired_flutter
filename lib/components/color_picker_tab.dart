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
      length: 3, //
      child: Column(
        children: [
          TabBar(
            labelColor: kDarkLabelClr,
            tabs: <Widget>[
              Tab(
                text: 'Library',
                // icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                text: 'Explore',
                // icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                text: 'Test',
                // icon: Icon(Icons.beach_access_sharp),
              ),
            ],
          ),
          Container(
            height: 400,
            child: TabBarView(
              children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: ColorPicker(
                      pickerColor: colorList[activeIndex].color,
                      onColorChanged: ((value) => ref
                          .read(colorObjProvider.notifier)
                          .pickColor(activeIndex, value)),
                    ),
                  ),
                ),
                Center(
                  child: Text("It's rainy here"),
                ),
                Center(
                  child: Text("It's It's third page here"),
                ),
              ],
            ),
          ),
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
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: (() => ref
                    .read(isPickingColorProvider.notifier)
                    .update((state) => !state)),
                child: Text('Apply'),
              )
            ],
          )
        ],
      ),
    );
  }
}
