import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'login.dart';

class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text('Profile',style: TextStyle(color: Colors.black)),
            ),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text('Profile',style: TextStyle(color: Colors.black)),
            ),
            body: Center(
              child: Text(
                'Error fetching user data',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text('Profile',style: TextStyle(color: Colors.black)),
            ),
            body: Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        final name = userData?['name'] as String?;
        final email = userData?['email'] as String?;
        final phone = userData?['phone'] as String?;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('Profile',style: TextStyle(color: Colors.black)),centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/SKED_PROFILE.jpg"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded,color: Colors.white,),
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle: TextStyle(color: Colors.greenAccent),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: TextEditingController(text: name),
                      enabled: false,
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle: TextStyle(color: Colors.greenAccent),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: TextEditingController(text: email),
                      enabled: false,
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,color: Colors.white,),
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle: TextStyle(color: Colors.greenAccent),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: TextEditingController(text: phone),
                      enabled: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: MaterialButton(
            onPressed: () {
              logout(context);
            },
            color: Colors.greenAccent,
            textColor: Colors.black,
            child: Icon(
              Icons.logout_rounded,
              size: 24,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),

        );
      },
    );
  }
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
