import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_scrs';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String messageText = '';
  List<Text> messageWidgets = [];


  void getCurrentUser() async {
    try{
      //await the current user that came in
      final user = await _auth.currentUser;
      //if the logged in user exist
      //print it
      if(user != null){
        loggedInUser = user;   //we want to use this later
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  //this method gets message from the database
  //we iterate our docs and print the data we got
  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs){
      print(message.data());
    }
  }

  //stream is diff, it gets updated as and when its happening
  //and since we are creating a message app its exactly what we need
  void messagesStream() async {
    final snapshops = _firestore.collection('messages').snapshots();
    await for (var snapshot in snapshops){
            for (var message in snapshot.docs){
              print(message.data());
            }

    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser(); //our method is printing the logged in user
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                getMessages();
                // _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              //keep streaming messages from firestore
              stream: _firestore.collection('messages').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //checking if snapshot has data
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    )
                  );
                } else{//if our snapshot or list has data
                  //copy/save those data into messages
                  final messages = snapshot.data.docs;
                  //iterate the doc in our messages
                  for(var message in messages){
                    //truncate text and sender from the message
                    //very important that data() not data
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];
                    //make a widget of each Text and Data
                    final messageWidget = Text(
                        "$messageText from $messageSender",
                        style: TextStyle(
                          fontSize: 50.0,
                        ),
                      );
                    //add the widget into our created Widget list
                    messageWidgets.add(messageWidget);
                  }
                }
                return Expanded( //expanded so that the container remain were it is
                  child: ListView( //list view instead of Column so as to be able to scroll
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    //display the widget
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //send it to firebase firestore collections called messages
                      //and add to text and sender
                      //where text is messageText which we collected from on change in TextField
                      //and loggedInUser which we got from User and .currentUser methods
                      _firestore.collection('messages').add({
                        'sender': loggedInUser.email,
                        'text': messageText,
                      }).then((value) => print("message Added"))
                          .catchError((error) => print("Failed to add message$error"));
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
