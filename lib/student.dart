import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sked/regularschedule.dart';
import 'package:sked/schedulepagestudent.dart';
import 'package:sked/notices.dart';
import 'package:sked/profile.dart';
import 'login.dart';
import 'model.dart';

class Student extends StatefulWidget {
  String id;
  Student({required this.id});
  @override
  _StudentState createState() => _StudentState(id: id);
}

class _StudentState extends State<Student> {
  String id;
  var role;
  var email;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  _StudentState({required this.id});
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
      FirebaseFirestore.instance.collection('posts').snapshots();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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


      body:
      Center(
        child: Column(
          children: <Widget>[
            Image.asset("assets/icons/sked_horizontal.jpg",height: 300,width: 500),
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Schedule()));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,border:Border.all(color: Colors.greenAccent, width: 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Icon(Icons.access_time_outlined,size: 50,color: Colors.white,),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Check Schedule",style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegularSchedule()));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,border:Border.all(color: Colors.greenAccent, width: 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_outlined,size: 50,color: Colors.white,),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Timetable",style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Notice(id: 'id',)));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,border:Border.all(color: Colors.greenAccent, width: 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message,size: 45,color: Colors.white,),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Notice",style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black,border:Border.all(color: Colors.greenAccent, width: 10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,size: 50,color: Colors.white,),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Profile",style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],),
                  ),
                ),
              ],

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            ),
          ],
        ),
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
