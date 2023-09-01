import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/src/model/home_model.dart';

class Firebasecollection {
  Firebasecollection._();
  static Firebasecollection firebasecollection = Firebasecollection._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getData1() {
    return firebaseFirestore.collection('Movie').snapshots();
  }

  void update(Temperatures temperatures, String docId) {
    firebaseFirestore
        .collection('Movie')
        .doc(docId)
        .update(temperatures.toJson());
  }
}
