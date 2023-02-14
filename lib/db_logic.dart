import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolors_inspired_flutter/auth_logic.dart';
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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var allColorHex = const <String>[];

  final user = ref.watch(authStateProvider).value;

  await for (var snapshot in _firestore
      .collection('savedColors')
      .where('uid', isEqualTo: user!.uid)
      .snapshots()) {
    allColorHex = [];

    for (DocumentSnapshot savedColor in snapshot.docs) {
      allColorHex = [...allColorHex, savedColor.get('colorHex')];
      print(allColorHex);
      yield allColorHex;
    }
  }
});
