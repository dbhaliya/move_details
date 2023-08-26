// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebase = FirebaseAuth.instance;

  //login & register
  Future<bool> sign_up(String email, String password) async {
    bool iscreate = false;
    await firebase
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      iscreate = true;
      print('success');
    }).catchError((error) {
      iscreate = false;
      print(error);
    });
    return iscreate;
  }

  Future<User?> sign_in(String email, String password) async {
      UserCredential user= await firebase
        .signInWithEmailAndPassword(email: email, password: password)
       .catchError((error) {
     
      print(error);
    });
    return user.user;
  }

  //check login-user
  Future<bool> checkUser() async {
    FirebaseAuth firebase = FirebaseAuth.instance;
    if (firebase.currentUser != null) {
      return true;
    }
    return false;
  }

  //check logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
