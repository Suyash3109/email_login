import 'package:email_login/home.dart';
import 'package:email_login/reg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreen createState() => _loginScreen();
}

class _loginScreen extends State<loginScreen> {
  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email field

    final emailfield = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: 'Email',
          label: Text('Email Address'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

//password field

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        hintText: 'Password',
        label: Text('Password'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter Your Password");
        }

        if (!regExp.hasMatch(value)) {
          return ("Please enter valid password");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
    );

//login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
//P
    );
    return Scaffold(
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
                      const CircleAvatar(
                        //child: AssetImage("assets/oo.jpg"),
// backgroundColor: Colors.redAccent,
                        backgroundImage: AssetImage('assets/oo.jpg'),
                        radius: 50,

                        //    child: SizedBox(

                        //     height:45,
                        //      child: Image.asset("assets/oo.jpg",
                        //     // bundle: AssetBundle(borderRadius: BorderRadius.circular(20),
                        //  fit: BoxFit.contain,
                        //    ),

                        //    ),
                      ),
                      SizedBox(height: 45),
                      emailfield,
                      SizedBox(
                        height: 35,
                      ),
                      passwordfield,
                      SizedBox(height: 25),
                      loginButton,
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegScr()));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.redAccent,
                                ),
                              ),
                            )
                          ])
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
