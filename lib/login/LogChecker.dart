import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Admin/AdminPanel.dart';
import 'package:flutter_application_1/Home_page/HomePanel.dart';
import 'package:flutter_application_1/login/login_page.dart';

import '../main.dart';

void main() {
  runApp(MyApp());
}

class LogChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && snapshot.data!.exists) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    if (data['User'] == 'Employ') {
                      return HomeDash();
                    } else if (data['User'] == 'Admin') {
                      return AdminPanel();
                    }
                  }
                  return LoginPage(); // Return LoginPage if user does not exist or 'User' field is not 'Employ' or 'Admin'
                }
              },
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
