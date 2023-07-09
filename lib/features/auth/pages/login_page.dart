import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/reusable_text.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/custom_otn_btn.dart';
import '../../../common/widgets/custom_text.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/showDialog.dart';
import '../controllers/auth_conroller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final phone = TextEditingController();

    Country country = Country(
      phoneCode: "81",
      countryCode: "JPN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Japan",
      example: "Japan",
      displayName: "Japan",
      displayNameNoCountryCode: "Japan",
      e164Key: "",
    );

    sendCodeToUser() {
      if (phone.text.isEmpty) {
        return showAlertDialog(
          context: context,
          message: "Please enter your phone number",
        );
      } else if (phone.text.length < 8) {
        return showAlertDialog(
          context: context,
          message: "Please enter a valid phone number",
        );
      } else {
        ref.read(authControllerProvider).sendSms(
              context: context,
              phone: '+${country.phoneCode}${phone.text}',
            );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: 300,
                ),
              ),
              const HeightSpacer(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.w),
                child: ReusableText(
                  text: "Please enter your phone number",
                  style: appstyle(17, AppConst.kLight, FontWeight.w500),
                ),
              ),
              const HeightSpacer(height: 20),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: AppConst.kBkDark,
                            bottomSheetHeight: AppConst.kHeight * 0.6,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          onSelect: (code) {
                            setState(() {
                              country = code;
                            });
                          },
                        );
                      },
                      child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}",
                        style: appstyle(
                          18,
                          AppConst.kBkDark,
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  hintText: "Enter phone number",
                  hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
                ),
              ),
              const HeightSpacer(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOtlnBtn(
                  onTap: () {
                    sendCodeToUser();
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHeight * 0.075,
                  color: AppConst.kBkDark,
                  color2: AppConst.kLight,
                  text: "Send Code",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
