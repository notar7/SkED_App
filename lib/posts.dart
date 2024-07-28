import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addpost.dart';
import 'editpost.dart';
import 'login.dart';

class posts extends StatefulWidget {
  @override
  _postsState createState() => _postsState();
}

class _postsState extends State<posts> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
  FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addnote()));
        },
        child: Icon(
          Icons.add,color: Colors.black,
        ),
        backgroundColor: Colors.greenAccent,
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Notices',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => editnote(docId: document),
                      ),
                    );
                  },
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
                                  document['title'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
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