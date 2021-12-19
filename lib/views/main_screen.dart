import 'package:flutter/material.dart';
import 'package:olaapp/views/login_screen.dart';
import 'package:olaapp/views/signin_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static String get idScreen => "main";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //THIS size PROVIDES US THE TOTAL HEIGHT AND WIDTH OF OUR SCREEN
    return Scaffold(
      resizeToAvoidBottomInset: false, //To avoid overflow whenever keyapd is up
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.64,
            width: size.width * 1.27,
            child: Positioned(
              child: SizedBox(
                height: size.height * 0.5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset("images/logo.jpg"),
                    ),
                  ],
                ),
              ),
            ),
          ), // image ends here
          const SizedBox(
            height: 40,
          ), // gap end here
          Column(
            children: <Widget>[
              const Text(
                "Explore new ways to",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                "travel with Meera",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 45,
              ),
              SizedBox(
                height: 40,
                width: 340,
                child: FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ), //"Login" button ends here
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 340,
                child: FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ), //"SignUp" button ends here
            ],
          ),
        ],
      ),
    );
  }
}
