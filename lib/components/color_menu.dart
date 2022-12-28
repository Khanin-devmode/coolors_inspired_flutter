import 'package:flutter/material.dart';

Future<dynamic> showColorMenu(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // const Text('Modal BottomSheet'),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // ),
              MenuItem(
                iconData: Icons.colorize,
                label: 'Pick Colors',
                hasNavigation: true,
              ),
              Divider(),
              MenuItem(
                iconData: Icons.add,
                label: 'Add Colors',
                hasNavigation: false,
              ),
              Divider(),
              MenuItem(
                iconData: Icons.remove,
                label: 'Remove Color',
                hasNavigation: false,
              ),
              Divider(),
              MenuItem(
                iconData: Icons.save,
                label: 'Save Color',
                hasNavigation: false,
              ),
              Divider(),
              MenuItem(
                iconData: Icons.copy,
                label: 'Copy Color',
                hasNavigation: false,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Cancel')],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      });
}

class MenuItem extends StatelessWidget {
  const MenuItem(
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
