import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference _savedColors;

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

  Future deleteSavedColor(String docId, Function successCallBack) async {
    _savedColors = _firestore.collection('savedColors');
    try {
      await _savedColors.doc(docId).delete();
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

final savedColorStreamProvider = StreamProvider<List<ColorDoc>>((ref) async* {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var allColorDoc = const <ColorDoc>[];

  final user = ref.watch(authStateProvider).value;

  await for (var snapshot in _firestore
      .collection('savedColors')
      .where('uid', isEqualTo: user!.uid)
      .snapshots()) {
    allColorDoc = [];

    for (DocumentSnapshot colorDoc in snapshot.docs) {
      Color color = Color(int.parse('0xff' + colorDoc.get('colorHex')));

      var savedColor = ColorDoc(colorDoc.id, color);

      allColorDoc = [...allColorDoc, savedColor];
      // print(allColorHex);
      yield allColorDoc;
    }
  }
});
