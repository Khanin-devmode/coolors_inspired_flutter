import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference _users;
  late CollectionReference _savedColors;
  late Stream<QuerySnapshot> _savedColorsStream;

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

  Stream<QuerySnapshot> getQueryStream() {
    return _firestore.collection('savedColors').snapshots();
  }
}

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

final savedColorStreamProvider = StreamProvider((ref) {
  // final db = Database();

  // db.initStream();

  // return db._savedColorsStream;
  return Database().getQueryStream();
});

// final savedColorsProvider = StreamProvider<List<String>>((ref) {
//   await FirebaseFirestore.instance.collection('savedColors');

// });

// class ChatService {
//   late Stream<List<ChatModel>> _stream;
//   Future<void> _init() async {
//     final Query _query = FirebaseFirestore.instance.collection('ChatModel');
//     final Stream<QuerySnapshot> _snapshots = _query.snapshots();
//     _stream = _snapshots.map((snapshot) {
//       final result = snapshot.docs
//           .map((element) => ChatModel.fromFirestore(element.data(), element.id))
//           .toList();
//       return result;
//     });
//   }

//   Stream<List<ChatModel>> stream() {
//     return _stream;
//   }
// }

// final chatMessageStreamProvider = StreamProvider<List<ChatModel>>((ref) {
//   final _service = ChatService();
//   _service._init();
//   return _service._stream;
// });