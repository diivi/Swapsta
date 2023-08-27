import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swapsta/models/swappable.dart';

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
        });
      }
      notifyListeners();
      SwappableProvider swappableProvider = SwappableProvider();
      await swappableProvider.fetchSwappables();
      await swappableProvider.fetchSwaps();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try {
      print('i am logging out');
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      print('i have logged out');
    } on Exception catch (e) {
      print(e);
    }
  }
}
