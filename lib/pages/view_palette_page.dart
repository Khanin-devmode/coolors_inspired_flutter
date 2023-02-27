import 'package:coolors_inspired_flutter/components/view_palette_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:color_converter/color_converter.dart';

class ViewPalettePage extends ConsumerStatefulWidget {
  const ViewPalettePage({super.key});

  @override
  ViewPalettePageState createState() => ViewPalettePageState();
}

class ViewPalettePageState extends ConsumerState<ViewPalettePage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<ColorObj> colorPalette = ref.read(
        viewingPaletteProvider); //ref.read to read only once, to subscribe use ref.watch

    ColorObj activeColor = colorPalette[activeIndex];

    Color labelClr = activeColor.color.isLight ? kDarkLabelClr : kWhiteLabelClr;

    return SafeArea(
      child: Scaffold(
        backgroundColor: activeColor.color,
        appBar: AppBar(
          centerTitle: true,
          title: Text('View Palette'),
          actions: [
            IconButton(
                onPressed: () {
                  showViewPaletteMenu(context, ref, true, false);
                },
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ColorInfo(
                      label: 'Hex',
                      info: activeColor.colorCode,
                      labelClr: labelClr),
                  ColorInfo(
                    label: 'RGB',
                    info: getRGBValue(activeColor.color),
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'CMYK',
                    info: CMYK.fromHex('#${activeColor.colorCode}').toString(),
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'HSB',
                    info: HSB.fromHex('#${activeColor.colorCode}').toString(),
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'HSL',
                    info: HSL.fromHex('#${activeColor.colorCode}').toString(),
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'LAB',
                    info: LAB.fromHex('#${activeColor.colorCode}').toString(),
                    labelClr: labelClr,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: List.generate(
                      colorPalette.length,
                      (index) => Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                activeIndex = index;
                              }),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: colorPalette[index].color,
                                    borderRadius: index == 0
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          )
                                        : index == colorPalette.length - 1
                                            ? BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              )
                                            : BorderRadius.all(Radius.zero)),

                                // color: colorPalette[index].color,
                                child: activeIndex == index
                                    ? Center(
                                        child: Icon(
                                          Icons.circle,
                                          size: 18,
                                          color: Colors.black87,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorInfo extends StatelessWidget {
  const ColorInfo(
      {super.key,
      required this.label,
      required this.info,
      required this.labelClr});

  final String label;
  final String info;
  final Color labelClr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: labelClr, fontSize: 16),
          ),
          Text(
            info,
            style: TextStyle(color: labelClr, fontSize: 24),
          )
        ],
      ),
    );
  }
}

String getRGBValue(Color color) {
  var r = color.red.toString();
  var g = color.green.toString();
  var b = color.blue.toString();

  return '$r, $g, $b';
}
