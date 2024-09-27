import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';

//Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();
//await Firebase.initializeApp();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
