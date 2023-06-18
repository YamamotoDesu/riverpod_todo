import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/custom_otn_btn.dart';

import '../../../common/widgets/appstyle.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../auth/pages/login_page.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset("assets/images/todo.png"),
          ),
          const HeightSpacer(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                text: "ToDo with Riverpod",
                style: appstyle(30, AppConst.kLight, FontWeight.w600),
              ),
              const HeightSpacer(height: 50),
              CustomOtlnBtn(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHeight * 0.06,
                  color: AppConst.kLight,
                  text: "Login with a phone number")
            ],
          ),
        ],
      ),
    );
  }
}
