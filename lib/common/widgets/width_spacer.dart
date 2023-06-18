import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidthSpacer extends StatelessWidget {
  const WidthSpacer({
    Key? key,
    required this.wydth,
  }) : super(key: key);

  final double wydth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wydth.w,
    );
  }
}
