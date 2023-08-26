import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future GoogleLogin() async {
    try {
      // add loading indicator
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);

      final usersCollection = FirebaseFirestore.instance.collection('users');
      final userEmail = googleUser.email;
      final userName = googleUser.displayName;
      print(usersCollection);
      final userDoc = await usersCollection.doc(userEmail).get();
      print("jijijiji");
      print(userDoc);
      if (!userDoc.exists) {
        // Create an initial user document with email as document ID
        await usersCollection.doc(userEmail).set({
          'name': userName,
          'email': userEmail,
          'items': [],
          'sentSwaps': [],
          'requestedSwaps': [],
        });
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on Exception catch (e) {
      print(e);
    }
  }
}
