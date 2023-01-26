import 'package:flutter/material.dart';

class AppMenuItem extends StatelessWidget {
  AppMenuItem(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.hasNavigation,
      this.menuFuncton})
      : super(key: key);

  final IconData iconData;
  final String label;
  final bool hasNavigation;
  Function? menuFuncton;

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
                  SizedBox(width: 16),
                  Text(label),
                ],
              ),
            ),
            Container(
              child: hasNavigation
                  ? Icon(
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
