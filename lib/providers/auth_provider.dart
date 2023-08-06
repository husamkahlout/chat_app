import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:string_validator/string_validator.dart';

import '../firebase/auth_helper.dart';
import '../firebase/firestore_helper.dart';
import '../models/user_model.dart';
import '../router/router.dart';
import '../views/pages/home/home_page.dart';
import '../views/resources/strings_manager.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> forgeKey = GlobalKey();
  GlobalKey<FormState> deleteKey = GlobalKey();
  TextEditingController signUpUserNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();
  TextEditingController deletePasswordController = TextEditingController();

  String? validateInput(String? value, String validationType) {
    if (validationType == "required") {
      if (value == null || value.isEmpty) {
        return StringsManager.requiredError.tr();
      }
    } else if (validationType == "email") {
      if (!isEmail(value!)) {
        return StringsManager.emailError.tr();
      }
    } else if (validationType == "password") {
      if (value!.length < 6) {
        return StringsManager.weakPassword.tr();
      }
    } else if (validationType == "confirmPassword") {
      if (value! != signUpPasswordController.text) {
        return StringsManager.confirmPasswordError.tr();
      }
    }
    return null;
  }

  bool isSecure = true;
  setVisibilty() {
    isSecure = !isSecure;
    notifyListeners();
  }

  notifyListenerss() {
    notifyListeners();
  }

  bool isLoading = false;
  UserModel? userModel;
// login function
  login() async {
    if (loginKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      UserCredential? credential = await AuthHelper.authHelper
          .login(loginEmailController.text, loginPasswordController.text);

      if (credential == null) {
        isLoading = false;
        notifyListeners();
      }
      if (credential != null) {
        userModel = await FirestoreHelper.firestoreHelper
            .getUserFromFirestore(credential.user!.uid);
        isLoading = false;
        notifyListeners();
        AppRouter.navigateWithReplacemenToWidget(const HomePage());
        signUpUserNameController.clear();
        signUpEmailController.clear();
        signUpPasswordController.clear();
        signUpConfirmPasswordController.clear();
        loginEmailController.clear();
        loginPasswordController.clear();
      }
    }
  }

// signUp function
  signUp() async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      UserCredential? credential = await AuthHelper.authHelper
          .signUp(signUpEmailController.text, signUpPasswordController.text);
      if (credential == null) {
        isLoading = false;
        notifyListeners();
      }
      if (credential != null) {
        userModel = UserModel(
            userID: credential.user!.uid,
            name: signUpUserNameController.text,
            email: signUpEmailController.text);
        FirestoreHelper.firestoreHelper.addUserToFirestore(userModel!);
        isLoading = false;
        notifyListeners();
        await AppRouter.navigateWithReplacemenToWidget(const HomePage());
        signUpUserNameController.clear();
        signUpEmailController.clear();
        signUpPasswordController.clear();
        signUpConfirmPasswordController.clear();
        loginEmailController.clear();
        loginPasswordController.clear();
      }
    }
  }

// check if the user logged in
  checkUser() async {
    log("check user");
    userModel = await AuthHelper.authHelper.checkUser();
  }

  signOut() {
    AuthHelper.authHelper.signOut();
  }

  forgetPassword() async {
    if (forgeKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      await AuthHelper.authHelper.forgetPassword(forgetPasswordController.text);
      isLoading = false;
      notifyListeners();
    }
  }

  deleteAccount() async{
    if (deleteKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
    await AuthHelper.authHelper.deleteAccount(deletePasswordController.text);
      isLoading = false;
      notifyListeners();
    }
  }

  checkPop() {
    if (Navigator.of(AppRouter.navKey.currentContext!).canPop()) {
      Navigator.pop(AppRouter.navKey.currentContext!);
      return Future.value(true);
    } else {
      log("cant Pop");
      return Future.value(false);
    }
  }
}
