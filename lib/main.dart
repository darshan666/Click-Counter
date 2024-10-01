import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDazQa2OYTXOKWt6VvoUc-510WYNdl1Ls4",
            authDomain: "flutter-login-fe8f6.firebaseapp.com",
            projectId: "flutter-login-fe8f6",
            storageBucket: "flutter-login-fe8f6.appspot.com",
            messagingSenderId: "346664626446",
            appId: "1:346664626446:web:8f668bbd94c230e9e48f5f",));
  }

  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}
