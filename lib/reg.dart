import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_login/home.dart';
import 'package:email_login/login.dart';
import 'package:email_login/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegScr extends StatefulWidget {
  const RegScr({Key? key}) : super(key: key);

  @override
  _RegScr createState() => _RegScr();
}

class _RegScr extends State<RegScr> {
  final _auth = FirebaseAuth.instance;
// our form key
  final _formkey = GlobalKey<FormState>();

//editing controller
  final firstNameeditingcontroller = new TextEditingController();
  final secondNameeditingcontroller = new TextEditingController();
  final Emaileditingcontroller = new TextEditingController();
  final passwordeditingcontroller = new TextEditingController();
  final confirmpasseditingcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first field

    final firstnamefield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'First Name',
          label: Text('First Name'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: firstNameeditingcontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter Your First Name");
        }

        if (!regExp.hasMatch(value)) {
          return ("Please enter valid name");
        }
      },
      onSaved: (value) {
        firstNameeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

//2nd name field

    final secondnamefield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Last Name',
          label: Text('Last Name'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: secondNameeditingcontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter Your Second Name");
        }

        if (!regExp.hasMatch(value)) {
          return ("Please enter valid Second Name");
        }
      },
      onSaved: (value) {
        secondNameeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    //email field

    final Emailfield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: 'Email',
          label: Text('Email Address'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: Emaileditingcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
//reg expression for email validation

        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Please enter a Valid email");
        }

        return null;
      },
      onSaved: (value) {
        Emaileditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    //password field

    final passworrdfield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          hintText: 'Password',
          label: Text('Password'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: passwordeditingcontroller,
      obscureText: true,

//keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (confirmpasseditingcontroller.text.length > 6 &&
            passwordeditingcontroller.text != value) {
          return "password dont match";
        }
        return null;
      },
      onSaved: (value) {
        passwordeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

//cnfrm passs

    final confirmpassworrdfield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          hintText: 'Confirm Password',
          label: Text('Confirm Password'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: confirmpasseditingcontroller,
      obscureText: true,

//keyboardType: TextInputType.emailAddress,
      validator: (value) {
        // RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter Your Password Again");
        }

        if (confirmpasseditingcontroller.text !=
            passwordeditingcontroller.text) {
          return ("Password doesn't match");
        }
      },
      onSaved: (value) {
        confirmpasseditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
    );

//signup button

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signup(Emaileditingcontroller.text, passwordeditingcontroller.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        //child: AssetImage("assets/oo.jpg"),
                        //backgroundColor: Colors.redAccent,
                        backgroundImage: AssetImage('assets/oo.jpg'),

                        radius: 50,

                        // child: SizedBox(
                        //   height: 45,
                        //   child: Image.asset(
                        //     "assets/oo.jpg",
                        //     // bundle: AssetBundle(borderRadius: BorderRadius.circular(20),
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 25),
                      firstnamefield,
                      SizedBox(height: 25),
                      secondnamefield,
                      SizedBox(height: 25),
                      Emailfield,
                      SizedBox(
                        height: 25,
                      ),
                      passworrdfield,
                      SizedBox(height: 25),
                      confirmpassworrdfield,
                      SizedBox(height: 25),
                      signupButton,
                      SizedBox(height: 25),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailstofirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
    ;
  }

  postDetailstofirestore() async {
// calling firestore
//calling usermodel
//sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameeditingcontroller.text;
    userModel.secondname = secondNameeditingcontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => loginScreen()),
        (route) => false);
  }
}
