import 'dart:developer';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  Auth._();

  static final Auth auth = Auth._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignInAccount? googleUser;

  getUserWithEmialAndPassword(
      {required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        log('The password is too weak');
      } else if (e.code == 'email already exist') {
        log('The account already exist..');
      }
    } catch (e) {
      log("$e");
    }
    if (credential != null) {
      return credential.user;
    } else {
      return null;
    }
  }

  signInUserWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential? credential;

    try {
      credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }

    if (credential != null) {
      return credential.user;
    } else {
      return null;
    }
  }

  getUserWithCredential() async {
    googleUser = await GoogleSignIn(scopes: ['email']).signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential? userCredential;
    userCredential = await firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}
