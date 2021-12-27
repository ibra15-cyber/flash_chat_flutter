import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static String id = 'login_screen';
}

class _LoginScreenState extends State<LoginScreen> {

  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: showSpinner,

      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  // to get a transition from hero widget
                  //wrap the item in a hero
                  //give it a tag
                  //give the other same item in the diff screen a tag name similar to the one here
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your email")),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your password")),
              SizedBox(
                height: 24.0,
              ),
              //this is factored with empty screen to forward us
              RoundedButton(
                Colors.lightBlueAccent,
                'Login',
                () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // try to get auth for a person by using the email and password they passed
                    // during registration
                    // authenticate it against firebase
                    // if the user exit
                    // send him to the chatScreen
                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);

                      setState(() {
                        showSpinner = false;
                      });
                    } else {
                      throw "couldn't sign in";
                    }
                  } catch (e) {
                    print(e);
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}