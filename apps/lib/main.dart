import 'package:apps/login.dart';
import 'package:apps/signup.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'landingpage.dart';
import 'eventdetailspage.dart';
=======
>>>>>>> 3dad3d2fecd2c11d1037a52ccaaa866951d69941

//Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();
//await Firebase.initializeApp();
<<<<<<< HEAD
//Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();
//await Firebase.initializeApp();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
=======
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
>>>>>>> 3dad3d2fecd2c11d1037a52ccaaa866951d69941
      apiKey: "AIzaSyCEfMaRKOG0Vb4PdWBayHX4qz_JxTPQL9Q",
      authDomain: "voluntrack-ad4a8.firebase.com",
      projectId: "voluntrack-ad4a8",
      storageBucket: "voluntrack-ad4a8.appspot.com",
      messagingSenderId: "254557740372",
      appId: "1:254557740372:android:34f3ee30ac7e986cf27cc1",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer Sign-Up',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(), // Set the registration screen as home
    );
  }
}
