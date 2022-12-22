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
              children: <Widget>[
                // const Text('Modal BottomSheet'),
                // ElevatedButton(
                //   child: const Text('Close BottomSheet'),
                //   onPressed: () => Navigator.pop(context),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.ios_share), Text('Export')],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.delete), Text('Export')],
                ),
              ],
            ),
          ),
        );
      });
}
