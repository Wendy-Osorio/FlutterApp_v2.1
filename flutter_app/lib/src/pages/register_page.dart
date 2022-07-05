import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/fluttericon.dart';
import 'package:flutter_app/src/pages/login_page.dart';
import 'package:flutter_app/src/widgets/app_outlinebutton.dart';
import 'package:flutter_app/src/widgets/app_textfield.dart';
import 'package:flutter_app/themes.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  late TapGestureRecognizer loginOnTap;
  @override
  void initState() {
    loginOnTap = TapGestureRecognizer();
    loginOnTap
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(),
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
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/register.jpg",
                    height: 250,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Themes.colorHeader,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppOutlineButton(
                    asset: "assets/google.png",
                    onTap: () {},
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
            SizedBox(height: 24),
            Text(
              "Or, register with email...",
              style: TextStyle(color: Colors.black38),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            AppTextField(
              hint: "Email ",
              icon: FlutterIcons.email,
            ),
            SizedBox(height: 12),
            AppTextField(
              hint: "Password",
              icon: FlutterIcons.lock,
            ),
            SizedBox(height: 12),
            AppTextField(
              hint: "Confirm Password",
              icon: FlutterIcons.lock,
            ),
            SizedBox(height: 12),
            AppTextField(
              hint: "User Name",
              icon: FlutterIcons.user,
            ),
            SizedBox(height: 15),
            Text.rich(
              TextSpan(
                text: "By signing up, you're agree to our ",
                children: [
                  TextSpan(
                    text: "Terms & Conditions",
                    style: TextStyle(
                      color: Themes.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 13),
            FlatButton(
              color: Themes.colorPrimary,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Register",
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
                  builder: (context) => LoginPage(),
                ));
              },
            ),
            SizedBox(height: 15),
            Text.rich(
              TextSpan(
                text: "Joined us before? ",
                children: [
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      color: Themes.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: loginOnTap,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
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
