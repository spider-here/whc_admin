
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../screens/home/homeScreen.dart';
import '../screens/landing/landing.dart';

class authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _extraAuth =
  FirebaseFirestore.instance.collection('admins');



  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        QuerySnapshot snapshot = await _extraAuth.where('uid', isEqualTo: value.user?.uid).get();
        if(snapshot.docs.isNotEmpty){
          Get.offAll(()=>homeScreen());
        }
        else {
          return Get.snackbar("Error", "User not found");
        }
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return Get.snackbar("Error", "Email already used. Go to login page.");

        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return Get.snackbar("Error", "Wrong Password");

        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
        return Get.snackbar("Error", "User not found");

        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";

        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
        return Get.snackbar("Error", "Too many requests to log into this account");

        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
        return Get.snackbar("Error", "Invalid Email");

        default:
          return Get.snackbar("Error", "Login Failed");
      }
    }
    return null;
  }

  Future signOutUser() async {
    await _auth.signOut().then((value) => Get.offAll(()=>const landing()));
  }

}