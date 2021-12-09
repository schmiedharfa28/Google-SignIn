import 'package:flutter/material.dart';
import 'package:flutter_google_sign/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_google_sign/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
