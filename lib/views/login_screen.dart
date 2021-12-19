import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:olaapp/helper/progress_dialog.dart';
import 'package:olaapp/main.dart';
import 'package:olaapp/views/inside_screen.dart';
import 'package:olaapp/views/main_screen.dart';
import 'package:olaapp/views/signin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //To avoid overflow whenever keyapd is up
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#F7F9F9"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
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
              "Login",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 22,
            width: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login to your account. It's free.",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          SizedBox(
            height: 200,
            width: 380,
            child: Container(
              //to add formkey
              child: Column(
                children: <Widget>[
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
                  ), //login
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 80,
                    width: 320,
                    child: TextFormField(
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
                if (!emailTextEditingController.text.contains("@")) {
                  displayToastMessage("Email is not valid.", context);
                } else if (passwordTextEditingController.text.length < 6) {
                  displayToastMessage("Password should be strong.", context);
                } else {
                  loginAndAuthenticateUser(context);
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ), // Login Button ends here
          ),
          const SizedBox(
            height: 50,
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
            height: 35,
          ),
          SizedBox(
            height: 50,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account ? ",
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
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 19,
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

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Authenticating, Pleae Wait.");
        });

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMssg) {
      Navigator.pop(context); //to pop Dialog Box whenever the user is logged in
      displayToastMessage("Error : " + errMssg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InsideScreen()));
          displayToastMessage("You are logged In", context);
        } else {
          Navigator.pop(
              context); // to pop Dialog Box whenever user is not signed in
          _firebaseAuth.signOut();
          displayToastMessage(
              "You are not Registered with us. Please Register Yourself",
              context);
        }
      });
    } else {
      Navigator.pop(context); // to pop Dialog Box whenever error occured
      displayToastMessage("Error Occured, Cannot Register You. ",
          context); //error occured-display error mssg
    }
  }
}
