import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'model.dart';

class Notice extends StatefulWidget {
  String id;
  Notice({required this.id});
  @override
  _NoticeState createState() => _NoticeState(id: id);
}

class _NoticeState extends State<Notice> {
  String id;
  var role;
  var email;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  _NoticeState({required this.id});

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.loggedInUser = UserModel.fromMap(value.data() as Map<String, dynamic>);
        email = loggedInUser.email.toString();
        role = loggedInUser.role.toString();
        id = loggedInUser.uid.toString();
      });
    }).catchError((error) {
      print("Error retrieving user data: $error");
    });
  }

  @override
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Notices',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                final document = snapshot.data!.docs[index];
                final title = document['title'] as String?;
                final timestamp = document['timestamp'] as Timestamp?;
                final creationDate = timestamp?.toDate();

                String formattedDate = '';
                if (creationDate != null) {
                  final formattedDateTime = DateTime.parse(creationDate.toString());
                  final day = formattedDateTime.day.toString().padLeft(2, '0');
                  final month = formattedDateTime.month.toString().padLeft(2, '0');
                  final year = formattedDateTime.year.toString();
                  final hour = formattedDateTime.hour.toString().padLeft(2, '0');
                  final minute = formattedDateTime.minute.toString().padLeft(2, '0');
                  formattedDate = 'Date: $day/$month/$year at $hour:$minute';
                }

                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.greenAccent, // Change border color to green ascent
                              width: 3,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.sticky_note_2_sharp,
                              size: 40,
                              color: Colors.white,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
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
