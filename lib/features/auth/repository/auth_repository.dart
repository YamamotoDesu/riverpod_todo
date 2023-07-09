import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/common/helpers/db_helper.dart';
import 'package:riverpod_todo/common/widgets/showDialog.dart';

import '../../../common/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await auth.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteGenerator.home,
        (route) => false,
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendOtp({required BuildContext context, required String phone}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          DBHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteGenerator.otp,
            (route) => false,
            arguments: {
              'phone': phone,
              'smsCodeId': verificationId,
            },
          );
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
