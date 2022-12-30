import 'package:flutter/material.dart';

class AppMenuItem extends StatelessWidget {
  const AppMenuItem(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.hasNavigation})
      : super(key: key);

  final IconData iconData;
  final String label;
  final bool hasNavigation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
    );
  }
}
