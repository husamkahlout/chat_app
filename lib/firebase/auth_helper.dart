import 'dart:developer';
import 'package:chat_app/views/pages/auth/signup_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../router/router.dart';
import '../views/pages/auth/login_page.dart';
import '../views/pages/home/home_page.dart';
import '../views/resources/strings_manager.dart';
import '../views/widgets/custom_toast.dart';
import 'firestore_helper.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  // signUp using firebase auth
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ShowMToast.errorToast(AppRouter.navKey.currentContext!,
            message: StringsManager.alreadyHaveAccount.tr(),
            alignment: Alignment.bottomCenter);
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // login using firebase auth
  Future<UserCredential?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowMToast.errorToast(AppRouter.navKey.currentContext!,
            message: StringsManager.noUserFound.tr(),
            alignment: Alignment.bottomCenter);
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowMToast.errorToast(AppRouter.navKey.currentContext!,
            message: StringsManager.wrongPassword.tr(),
            alignment: Alignment.bottomCenter);
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }

  String getCurrentUserID() {
    return firebaseAuthInstance.currentUser!.uid;
  }

// signout
  signOut() async {
    try {
      AppRouter.navigateWithReplacemenToWidget(const LoginPage());
      firebaseAuthInstance.signOut();
      log("log out");
    } catch (e) {
      log(e.toString());
    }
  }

// check user if he logged in or not
  Future<UserModel?> checkUser() async {
    User? user = firebaseAuthInstance.currentUser;
    if (user == null) {
      await Future.delayed(const Duration(seconds: 0));
      AppRouter.navigateWithReplacemenToWidget(const SignUpPage());
    } else {
      await Future.delayed(const Duration(seconds: 0));
      UserModel userModel =
          await FirestoreHelper.firestoreHelper.getUserFromFirestore(user.uid);
      AppRouter.navigateWithReplacemenToWidget(const HomePage());
      return userModel;
    }
    return null;
  }

  forgetPassword(String email) async {
    try {
      await firebaseAuthInstance.sendPasswordResetEmail(email: email);
      ShowMToast.successToast(AppRouter.navKey.currentContext!,
          message: StringsManager.forgetPasswordSuccess.tr(),
          alignment: Alignment.topCenter);
      Provider.of<AuthProvider>(AppRouter.navKey.currentContext!, listen: false)
          .forgetPasswordController
          .clear();
    } on Exception catch (e) {
      ShowMToast.errorToast(AppRouter.navKey.currentContext!,
          message: StringsManager.noUserFound.tr(),
          alignment: Alignment.topCenter);
      log(e.toString());
    }
  }

  deleteAccount(String password) async {
    User? user = firebaseAuthInstance.currentUser;
    try {
      await user!.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password));
      await FirestoreHelper.firestoreHelper.deleteUserFromFirestore(user.uid);
      await user.delete();
      Provider.of<AuthProvider>(AppRouter.navKey.currentContext!, listen: false)
          .deletePasswordController
          .clear();
      AppRouter.popUntil(const LoginPage());
      ShowMToast.successToast(AppRouter.navKey.currentContext!,
          message: StringsManager.deleteIsDone.tr(),
          alignment: Alignment.topCenter);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ShowMToast.errorToast(AppRouter.navKey.currentContext!,
            message: StringsManager.wrongPassword.tr(),
            alignment: Alignment.topCenter);
      }
    }
  }
}
