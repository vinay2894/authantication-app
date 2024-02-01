import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viva_2/helper/firebase_auth_helper.dart';
import 'package:viva_2/helper/firestore_helper.dart';
import 'package:viva_2/models/user_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the Email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Enter the Email",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the Password";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Enter the Password",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      User? user = await Auth.auth.signInUserWithEmailPassword(
                        email: email.text,
                        password: password.text,
                      );
                      if (user != null) {
                        Navigator.of(context).pushReplacementNamed('home_page');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Invalid Email or Password"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    User? user = await Auth.auth.getUserWithCredential();

                    if (user != null) {
                      UserModel userModel = UserModel(
                        email: email.text,
                        password: password.text,
                      );
                      FirebaseHelper.firebaseHelper
                          .adduser(
                            userModel: userModel,
                          )
                          .then(
                            (value) => Navigator.of(context)
                                .pushReplacementNamed('home_page'),
                          );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  child: Text("Google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
