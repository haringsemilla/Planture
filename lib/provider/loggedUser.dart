// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoggedUser with ChangeNotifier {
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
