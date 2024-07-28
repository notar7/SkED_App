import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'posts.dart';

class editnote extends StatefulWidget {
  final DocumentSnapshot docId;

  editnote({required this.docId});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docId['title']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Notice',style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {
              _updateNote();
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              _deleteNote();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
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

  void _updateNote() {
    widget.docId.reference.update({
      'title': title.text,
      'timestamp': Timestamp.now(), // Update the timestamp to the current date and time
    }).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => posts()),
      );
    }).catchError((error) {
      print('Error updating note: $error');
    });
  }


  void _deleteNote() {
    widget.docId.reference.delete().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => posts()),
      );
    }).catchError((error) {
      print('Error deleting note: $error');
    });
  }
}
