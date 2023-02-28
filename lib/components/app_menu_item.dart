import 'package:flutter/material.dart';

class AppMenuItem extends StatelessWidget {
  const AppMenuItem(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.hasNavigation,
      this.menuFuncton})
      : super(key: key);

  final IconData iconData;
  final String label;
  final bool hasNavigation;
  final Function? menuFuncton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: menuFuncton != null ? () => menuFuncton!() : (() {}),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: menuFuncton != null
                      ? Row(
                          children: [
                            Icon(iconData),
                            const SizedBox(width: 16),
                            Text(label),
                          ],
                        )
                      : Row(
                          children: [
                            Icon(
                              iconData,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              label,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                ),
                Container(
                  child: hasNavigation
                      ? const Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
