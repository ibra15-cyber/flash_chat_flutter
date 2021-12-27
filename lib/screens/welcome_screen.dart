import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller ;
  late Animation _animation;
  late Animation _animationColorTwin;

  @override
  void initState() {
    super.initState();

    //data to use the controller
    //but since it's going to be changing we put it into a state
    //so we choose initState
    //hence it will load the very first time our code loads

    _controller = AnimationController(
        duration: Duration(seconds: 10), //can take how much long
        //the ticker which is our class with state and adding
        //and adding another property tickerProvider
        //so how class becomes the thicker provider
        vsync: this,
        // upperBound: 100,
    );

    //animation for CurvedAnimation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);

    //animation for colorTween
    //start from one color and end at another, animate with our defined controller
    _animationColorTwin = ColorTween(begin: Colors.blue, end: Colors.blue).animate(_controller);

    _controller.forward(); //proceed from 0 to 1
    //controller needs a listener
    //that's we want to know what our controller is doing
    //in our case we are only printing the values
    _controller.addListener(() {
      setState(() {});
      // print(_animation.value);
    });

    //using statusListener to control continues run for both forward and reverse
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed){
        _controller.forward();
      }
      // print(status);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: _animationColorTwin.value,
      //we are applying the controller value for color
      // Colors.blue.withOpacity(_controller.value /100 ), //using only controller animation
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    //and again we are applying our controller value which ranges
                    //from 0.0 to 1.0 to height
                    //so instead of hard codding it
                    //we tell it to animate
                    height: _animation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                    //we can display the controller values in text because both are string
                    // '${_controller.value.toInt()}%',
                    text: ['Flash Chat'],
                    onTap: (){ },
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                Colors.lightBlueAccent,
                'Log In',
                //because we used static id's as name
                //instead of using the push method, we can use the pushName
                () async {
                  Navigator.pushNamed(context, LoginScreen.id);
                }
                ),
            RoundedButton(
                Colors.lightBlue,
                'Register',
                    () async {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                })
        ],
        ),
      ),
    );
  }
}

