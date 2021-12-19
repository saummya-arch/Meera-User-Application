// ignore_for_file: unused_field, unnecessary_string_escapes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:olaapp/helper/progress_dialog.dart';
import 'package:olaapp/main.dart';
import 'package:olaapp/views/inside_screen.dart';
import 'package:olaapp/views/login_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _showPassword = true;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //To avoid pverflow whenever keyapd is up
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#F7F9F9"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30.0,
          ),
          const SizedBox(
            height: 40,
            child: Text(
              "Register",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 22,
            width: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Register yourself. It's free.",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            height: 280,
            width: 380,
            child: Container(
              //to add formkey
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                    width: 320,
                    child: TextFormField(
                      controller: nameTextEditingController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Username",
                      ),
                    ),
                  ), //username
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    width: 320,
                    child: TextFormField(
                      controller: emailTextEditingController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Email",
                      ),
                    ),
                  ), //email
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    width: 320,
                    child: TextFormField(
                      obscureText: _showPassword,
                      controller: passwordTextEditingController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Password",
                        // suffixIcon: InkWell(
                        //   onTap: _togglePasswordButton,
                        //   child: Icon(
                        //     _showPassword
                        //         ? Icons.visibility
                        //         : Icons.visibility_off,
                        //     size: 15,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ),
                    ),
                  ), //password
                ],
              ),
            ),
          ), //whole login and password column ends here
          const SizedBox(
            height: 0,
          ),
          SizedBox(
            height: 50,
            width: 320,
            child: FlatButton(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                if (nameTextEditingController.text.length < 3) {
                  displayToastMessage(
                      "Username must be 3 characters long.", context);
                } else if (!emailTextEditingController.text.contains("@")) {
                  displayToastMessage("Email is not valid.", context);
                } else if (passwordTextEditingController.text.length <
                        6 /*||
                    !passwordTextEditingController.text.contains(
                        "^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})")*/
                    ) {
                  displayToastMessage(
                      "Password should be strong. \nPassword must contain at least one digit [0-9].\nPassword must contain at least one lowercase Latin character [a-z].\nPassword must contain at least one uppercase Latin character [A-Z].\nPassword must contain at least one special character like ! @ # & ( ).\nPassword must contain a length of at least 6 characters and a maximum of 20 characters.",
                      context);
                } else {
                  registerNewUser(context);
                }
              },
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ), // Login Button ends here
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            height: 80,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 43,
                  width: 140,
                  child: FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 22,
                          width: 32,
                          child: Image.asset("images/google.png"),
                        ),
                        const Text(
                          "Google",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ), // google button in row ends here
                SizedBox(
                  height: 43,
                  width: 140,
                  child: FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 22,
                          width: 32,
                          child: Image.asset("images/facebook.png"),
                        ),
                        const Text(
                          "Facebook",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ), // facebook button in row ends here
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 40,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account ? ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ), // last "already have an account button ends here"
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Registering, Pleae Wait.");
        });

    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMssg) {
      Navigator.pop(context); //to pop Dialog Box whenever the user is logged in

      displayToastMessage("Error : " + errMssg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) // user created
    {
      Map userDataMap = {
        "name": nameTextEditingController.text,
        "email": emailTextEditingController.text,
      };

      userRef
          .child(firebaseUser.uid)
          .set(userDataMap); //save user info to database
      displayToastMessage("The User has been successfully created.", context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InsideScreen()),
      );
    } else {
      Navigator.pop(context); //to pop Dialog Box

      displayToastMessage("New User Account has not been created. ",
          context); //error occured-display error mssg
    }
  }

  void _togglePasswordButton() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
