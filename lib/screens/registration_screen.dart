import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';




class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
                  email = value;
                },
                decoration: kTextFieldDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  Colors.blueAccent,
                  'Register',
                  () async {

                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      //try to get auth for a person by using the email and password they passed
                      //during registration
                      //authenticate it against firebase
                      //if the user exit
                      //send him to the chatScreen
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);

                        //once the screen has been pushed stop spinning
                        setState(() {
                          showSpinner = false;
                        });
                      } else {
                        print(email);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
              )

            ],
          ),
        ),
      ),
    );
  }
}


//this is factoring it with the class widget
//with decoration we decided to make it into a constant and using copywith to change the instance we want

// Padding(
// padding: EdgeInsets.symmetric(vertical: 16.0),
// child: Material(
// color: Colors.blueAccent,
// borderRadius: BorderRadius.all(Radius.circular(30.0)),
// elevation: 5.0,
// child: MaterialButton(
// onPressed: () {
// //Implement registration functionality.
// },
// minWidth: 200.0,
// height: 42.0,
// child: Text(
// 'Register',
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
