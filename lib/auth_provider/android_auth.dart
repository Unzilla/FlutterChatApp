import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_provider_base.dart';
class AndroidAuthProvider implements AuthProviderBase{
  @override
  Future<FirebaseApp>initialize() async{
    return await Firebase.initializeApp(
      name:"Flutter chat",
      options: FirebaseOptions(
          apiKey: "AIzaSyCAaySgynQLLIeNROPbBP10ToWGUGhfHCc",
          authDomain: "flutter-chat-bd0c4.firebaseapp.com",
          projectId: "flutter-chat-bd0c4",
          storageBucket: "flutter-chat-bd0c4.appspot.com",
          messagingSenderId: "991909621818",
          appId: "1:991909621818:android:7754fff5772c33c7ccc503")

    );
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    throw UnimplementedError();
  }

}
class AuthProvider extends AndroidAuthProvider{

}