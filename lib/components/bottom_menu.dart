import 'package:flutter/material.dart';

Future<dynamic> showBottomMenu(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                // const Text('Modal BottomSheet'),
                // ElevatedButton(
                //   child: const Text('Close BottomSheet'),
                //   onPressed: () => Navigator.pop(context),
                // ),
                MenuItem(
                  iconData: Icons.ios_share,
                  label: 'Export',
                ),
                Divider(),
                MenuItem(iconData: Icons.delete, label: 'delete'),
                Divider(),
              ],
            ),
          ),
        );
      });
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, required this.iconData, required this.label})
      : super(key: key);

  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Icon(iconData), Text(label)],
      ),
    );
  }
}
