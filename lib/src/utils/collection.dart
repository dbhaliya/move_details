import 'package:cloud_firestore/cloud_firestore.dart';

class Firebasecollection {
  Firebasecollection._();
  static Firebasecollection firebasecollection = Firebasecollection._();
  Stream<QuerySnapshot<Map<String, dynamic>>> getData1() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection('Movies').snapshots();
  }
}
