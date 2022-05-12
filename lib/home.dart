import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_login/login.dart';
import 'package:email_login/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUSer = UserModel();

  var val;
  @override
  void initState() {
    setState(() {
      getData();
    });
    // TODO: implement initState
    super.initState();
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      val = value;
      loggedInUSer = UserModel.fromMap(value.data());
      // print(value['email']);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/oo.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${loggedInUSer.firstName} ${loggedInUSer.secondname}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${loggedInUSer.email}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    // getData();
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => loginScreen()));
  }
}
