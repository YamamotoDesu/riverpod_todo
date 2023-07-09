// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';

import '../repository/auth_repository.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({
    Key? key,
    required this.smsCodeId,
    required this.phone,
  }) : super(key: key);

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authRepositoryProvider).verifyOtp(
          context: context,
          verificationId: smsCodeId,
          smsCodeId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeightSpacer(height: AppConst.kHeight * 0.12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: AppConst.kWidth * 0.5,
                ),
              ),
              const HeightSpacer(
                height: 26,
              ),
              ReusableText(
                text: "Enter your otp code",
                style: appstyle(
                  18,
                  AppConst.kLight,
                  FontWeight.bold,
                ),
              ),
              const HeightSpacer(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (value) {
                    if (value.length == 6) {
                      return verifyOtpCode(context, ref, value);
                    }
                  },
                  onSubmitted: (value) {
                    if (value.length == 6) {
                      return verifyOtpCode(context, ref, value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
