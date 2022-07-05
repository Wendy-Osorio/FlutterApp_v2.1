import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app/src/pages/login_page.dart';

String userEmail = " ";

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

  userEmail = googleUser.email;

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        backgroundColor: Themes.colorPrimary,
      ),
      body: Center(
          child: Center(
        child: Text('Mi contenido'),
      )),
      drawer: Drawer(
          child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Wendy Osorio"),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.postimg.cc/YSWTKjVF/profile-example.jpg')),
            decoration: BoxDecoration(
              color: Themes.colorHeader,
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () => {},
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () => {},
          ),
          ListTile(
              title: Text('Sign Off'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                userEmail = "";
                await GoogleSignIn().signOut();
                setState(() {});
              }),
        ],
      )),
    );
  }
}
