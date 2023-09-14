import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LoginController extends GetxController {
    SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;


  SMIInput<bool>? HOME;
  SMIInput<bool>? SEARCH;
  SMIInput<bool>? BELL;
  SMIInput<bool>? USER;
  SMIInput<bool>? CHAT;
  SMIInput<bool>? TIMER;

  String ? email ;
   String ? password ;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.onInit();
  }


  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }
}
