import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';
import 'package:flutter_app/fluttericon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app/src/pages/home_page.dart';
import 'package:flutter_app/src/pages/register_page.dart';
import 'package:flutter_app/src/widgets/app_textfield.dart';
import 'package:flutter_app/src/widgets/app_outlinebutton.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  late TapGestureRecognizer registerOnTap;
  @override
  void initState() {
    registerOnTap = TapGestureRecognizer();
    registerOnTap
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegisterPage(),
          ),
        );
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Image.asset(
              "assets/login.jpg",
              height: 250,
            ),
            Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Themes.colorHeader,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 12),
            AppTextField(
              hint: "Email",
              icon: FlutterIcons.email,
            ),
            SizedBox(height: 12),
            AppTextField(
              hint: "Password",
              icon: FlutterIcons.lock,
            ),
            SizedBox(height: 12),
            Text(
              "Forgot Password?",
              style: TextStyle(color: Themes.colorPrimary, fontSize: 15),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 12),
            RaisedButton(
              color: Themes.colorPrimary,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  if (_loading)
                    Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(left: 20),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              onPressed: () {
                _login(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
            ),
            SizedBox(height: 24),
            Text(
              "OR",
              style: TextStyle(color: Colors.black38),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppOutlineButton(
                    asset: "assets/google.png",
                    onTap: () async {
                      await signInWithGoogle();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: AppOutlineButton(
                    asset: "assets/facebook.png",
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: AppOutlineButton(
                    asset: "assets/apple.png",
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text.rich(
              TextSpan(
                text: "New to iThickLogistics? ",
                children: [
                  TextSpan(
                    text: "Register",
                    style: TextStyle(
                      color: Themes.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: registerOnTap,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }
}
