

import 'package:flutter/cupertino.dart';
import 'package:movies/src/model/home_model.dart';


class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  List<Temperatures> data = [];
  bool hide = true;
  void chnageicon(value) {
    hide = value;
    notifyListeners();
  }

  
}

class FirebaseHelper {}
