import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final filePath = 'counters/${user.uid}/counter.txt';
        final ref = _storage.ref().child(filePath);

        final data = await ref.getData(1024);
        if (data != null) {
          setState(() {
            _counter = int.parse(String.fromCharCodes(data));
          });
        }
      } catch (e) {
        print("Error loading counter: $e");
      }
    }
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final filePath = 'counters/${user.uid}/counter.txt';
        final ref = _storage.ref().child(filePath);

        await ref.putData(Uint8List.fromList(_counter.toString().codeUnits));
      } catch (e) {
        print("Error uploading counter: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Button pressed this many times:',
            ),
            Text(
              '$_counter'
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInScreen()));
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
