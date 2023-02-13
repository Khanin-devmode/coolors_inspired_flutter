import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference _users;
  late CollectionReference _savedColors;

  // Add a user with uid
  // A method that will add a new Movie m to our Movies collection and return true if its successful.
  // Future<bool> addNewUser(String userId) async {
  //   _users = _firestore.collection('users');
  //   try {
  //     await _users.add({'uid': userId, 'savedColors': []});
  //     return true;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future saveColor(
      String colorHex, String uid, Function successCallBack) async {
    _savedColors = _firestore.collection('savedColors');
    try {
      await _savedColors.add({'uid': uid, 'colorHex': colorHex});
      successCallBack();
      // return true;
    } catch (e) {
      // return Future.error(e);
    }
  }
}

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

final savedColorStreamProvider = StreamProvider<List<String>>((ref) async* {
  // final db = Database();

  // db.initStream();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  print('providing stream');

  // Database().savedColorStream();

  await for (var snapshot in _firestore.collection('savedColors').snapshots()) {
    var allColorHex = const <String>[];

    for (DocumentSnapshot savedColor in snapshot.docs) {
      // print(savedColor.data());
      // print(savedColor.get('colorHex'));
      allColorHex = [...allColorHex, savedColor.get('colorHex')];
      print(allColorHex);
      yield allColorHex;
    }
  }
});
