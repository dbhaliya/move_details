import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/src/my_app.dart';
import 'package:movies/src/utils/shardprefrence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalDatabase.localDatabase.saredPreferencesAsign();
  runApp(const MyApp());
}
