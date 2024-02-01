import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viva_2/models/user_model.dart';

class FirebaseHelper {
  FirebaseHelper._();

  static final FirebaseHelper firebaseHelper = FirebaseHelper._();

  String collectionpath = "Users";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUser() {
    return firestore.collection(collectionpath).snapshots();
  }

  Future<void> adduser({required UserModel userModel}) async {
    firestore
        .collection(collectionpath)
        .doc(userModel.email)
        .set(userModel.toMap)
        .then(
          (value) => log("created"),
        );
  }

  Future<void> updateUser({required UserModel userModel}) async {
    firestore
        .collection(collectionpath)
        .doc(userModel.email)
        .update(userModel.toMap);
  }

  Future<void> deleteUser({required UserModel userModel}) async {
    firestore.collection(collectionpath).doc(userModel.email).delete();
  }
}
