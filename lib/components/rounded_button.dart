import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';



class RoundedButton extends StatelessWidget {
  Color color;
  String title;
  // String pushNamed;
  VoidCallback onPressed;

  RoundedButton(this.color, this.title, @required this.onPressed){}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color, //hardcoded color replaced with variable color hence any callback to that class will provide its specific color
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton (
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),//diff titles for diff text
          ),
        ),
      ),
    );
  }
}
//so instead of extracting the whole function return to represent onPressed
//i could onPressed: onPressed
//where in the class property a fn onPressed will have return type Function

//but since we are only changing only one aspect of the whole fn
//i declare a property string so that onPressed = () { string }
//so that the string changes
