import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';

class GeneratePalettePage extends ConsumerWidget {
  const GeneratePalettePage({super.key});

  // void initState() {
  //   super.initState();
  //   ShakeDetector detector = ShakeDetector.autoStart(
  //     onPhoneShake: () {
  //       _generateColor();
  //     },
  //     minimumShakeCount: 1,
  //     // shakeSlopTimeMS: 500,
  //     // shakeCountResetTime: 1000,
  //     shakeThresholdGravity: 1.5,
  //   );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ColorObj> colorObj = ref.watch(colorObjProvider);

    return SafeArea(
      child: Scaffold(
          body: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              ref.read(colorObjProvider.notifier).reorder(oldIndex, newIndex);
            },
            physics: NeverScrollableScrollPhysics(),
            itemCount: colorObj.length,
            itemBuilder: (BuildContext context, int index) {
              return ColorRow(
                  colorObj: colorObj[index],
                  toggleLock: () => ref
                      .read(colorObjProvider.notifier)
                      .toggleLock(colorObj[index]),
                  key: Key('$index'));
            },
          ),
          bottomNavigationBar: Container(
            height: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () =>
                              ref.read(colorObjProvider.notifier).undo(),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () =>
                              ref.read(colorObjProvider.notifier).redo(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: (() =>
                          ref.read(colorObjProvider.notifier).generateColor()),
                      child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 50,
                          color: Colors.grey,
                          child: Text('Generate'))),
                ],
              ),
            ),
          )),
    );
  }
}

class ColorRow extends StatelessWidget {
  const ColorRow({Key? key, required this.colorObj, required this.toggleLock})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: colorObj.color,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(colorObj.colorCode),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => toggleLock(),
            child: Container(
              child: colorObj.isLocked
                  ? const Icon(Icons.lock_outline)
                  : const Icon(Icons.lock_open),
            ),
          ),
        ),
      ]),
    );
  }
}