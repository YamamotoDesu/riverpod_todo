import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifyOtp(
      context: context,
      verificationId: verificationId,
      smsCodeId: smsCodeId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }

  void sendSms({
    required BuildContext context,
    required String phone,
  }) {
    authRepository.sendOtp(context: context, phone: phone);
  }
}
