import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sked/home.dart';
import 'package:sked/login.dart';
import 'package:sked/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async{
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted){
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black),
          color: Colors.greenAccent,),
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(labelColor: Colors.black),
      ),
      home: isLogin ? HomePage() : WelcomeScreen(),
    );
  }
}
