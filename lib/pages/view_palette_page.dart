import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinycolor2/tinycolor2.dart';

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
        colorListProvider); //ref.read to read only once, to subscribe use ref.watch

    ColorObj activeColor = colorPalette[activeIndex];

    Color labelClr = activeColor.color.isLight ? kDarkLabelClr : kWhiteLabelClr;

    return SafeArea(
      child: Scaffold(
        backgroundColor: activeColor.color,
        appBar: AppBar(
          centerTitle: true,
          title: Text('View Palette'),
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
                    info: activeColor.colorCode,
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'CMYK',
                    info: activeColor.colorCode,
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'HSB',
                    info: activeColor.colorCode,
                    labelClr: labelClr,
                  ),
                  ColorInfo(
                    label: 'HSL',
                    info: activeColor.colorCode,
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
                                      ))
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label),
          Text(
            info,
            style: TextStyle(color: labelClr),
          )
        ],
      ),
    );
  }
}
