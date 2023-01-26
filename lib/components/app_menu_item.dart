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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: menuFuncton != null ? () => menuFuncton!() : (() {}),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(iconData),
                  const SizedBox(width: 16),
                  Text(label),
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
    );
  }
}
