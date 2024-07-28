import 'posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Notice',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'timestamp': FieldValue.serverTimestamp(), // Add timestamp field
              }).whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => posts()),
                );
              });
            },
            child: Icon(
              Icons.save,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200, // Adjust the height as needed
              child: TextFormField(
                controller: title,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Notice',
                  labelStyle: TextStyle(color: Colors.greenAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width:3,color: Colors.greenAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width:3,color: Colors.greenAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
