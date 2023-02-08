import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference _users;

  // Add a user with uid
  // A method that will add a new Movie m to our Movies collection and return true if its successful.
  Future<bool> addUser(String userId) async {
    _users = _firestore.collection('movies');
    try {
      await _users.add({'uid': userId, 'savedColors': []});
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
