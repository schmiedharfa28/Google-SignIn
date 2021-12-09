import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google SignIn"),
      ),
      body: Container(
          child: Center(
              child: Column(
        children: [
          MaterialButton(
            child: Text(
              "Login with Google Account",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueGrey,
            onPressed: () {
              _handleGoogleSign();
            },
          ),
          MaterialButton(
              child: Text(
                "Logout with Google Account",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                _signOut();
              })
        ],
      ))),
    );
  }

  Future<void> _handleGoogleSign() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth!.accessToken,
      accessToken: googleAuth.accessToken,
    );

    UserCredential result = await _auth.signInWithCredential(credential);
    final User? user = result.user;

    _alertDialog(user);
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
  }

  void _alertDialog(User? user) {
    AlertDialog dialog = AlertDialog(
      content: Container(
        height: 230.0,
        child: Column(
          children: <Widget>[
            Text(
              'Sudah Login',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Divider(),
            ClipOval(
              child: Image.network(user!.photoURL ?? ""),
            ),
            Text('Anda Login sebagai ${user.displayName}'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: MaterialButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (contex) => dialog);
  }
}
