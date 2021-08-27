import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'auth_provider/android_auth.dart';
import 'auth_provider/message_widget.dart';
import 'auth_provider/message_WALL.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthProvider().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Chat Crew'),
    );
  }
}

class MyHomePage extends  StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;
  final store=FirebaseFirestore.instance.collection(
      'chat_messages');


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool signIn = false;

  void _signIn() async {
    try {
      final creds = await AuthProvider().signInWithGoogle();
      print(creds);
      setState(() {
        signIn = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        centerTitle: true,
        actions: [
          if(signIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InkWell(
                onTap: signOut,
                child: Icon(Icons.logout),

              ),
            )
        ],
      ),
      backgroundColor: Color(0Xffdee2d6),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: widget.store.orderBy('timestamp').snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data.docs.isEmpty)
                      return Center(
                        child: Text(
                          "No messages to display"
                        ),
                      );
                    return MessageWall(
                        messages: snapshot.data.docs,
                      onDelete: deleteMessage,

                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )

          ),

          if(signIn)
            MessageForm(
            onSubmit: addMessage,

    )else
            Container(
                padding: const EdgeInsets.all(5),
                child: SignInButton(
                    Buttons.Google, onPressed: () {
                  _signIn();
                }


                )

            )

        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      signIn = false;
    });
  }

  void addMessage(String value) async {

    final user = FirebaseAuth.instance.currentUser;
    final displayName=user.displayName;
    print('user $displayName');
    if (user != null) {
      await widget.store.add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'photo_url': user.photoURL ?? 'https://via.placeholder.com/150',


        'timestamp': Timestamp
            .now()
            .millisecondsSinceEpoch,
        'value': value,
      }

      );
    }
  }
  void deleteMessage(String docId) async{
    await widget.store.doc(docId).delete();
  }
}

