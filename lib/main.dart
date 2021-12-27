import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}


class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // // we decided to remove the dark theme because we did everything/decoration manually
      // theme: ThemeData.dark().copyWith(
      //   hintColor: Colors.grey,
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black),
      //   ),
      // ),
      //
      // we are telling main to first load the welcomeScreen()
      //   its able to do that because the value of our routes are real classes
      //   the string part can be anything but should be the same thing passed in home or initial route
      initialRoute: WelcomeScreen.id, //or initialRoute
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
    }
    );
  }
}


//custom animation needs a ticker or time that used to insist change
//2. animation controller is the controller what should be done
//3. value usually from 0.0 to 1.0 between which stuff change
//also since the upper bound of transition is 1 changing it to 100 means
//we will have to change the value of doubles that will take values of controller
//but since now the controller is more way beyond them we reduce were we make the
//call divided 100