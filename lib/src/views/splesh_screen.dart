// ignore_for_file: unnecessary_import, avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/src/utils/authantication.dart';
import 'package:movies/src/views/home_page.dart';
import 'package:movies/src/views/login.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    iSlogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Lottie.asset("assets/json/animation_lm00x6j9.json"),
        ),
      ),
    );
  }

  Future<void> iSlogin() async {
    bool isLogin = await FirebaseAuthHelper.firebaseAuthHelper.checkUser();
    print("===== $isLogin");
    if (isLogin) {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      );
    }
  }
}