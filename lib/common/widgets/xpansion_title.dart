// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'tile.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile({
    Key? key,
    required this.text,
    required this.text2,
    this.onExpansionChanged,
    this.trailing,
    required this.children,
  }) : super(key: key);

  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.kBkLight,
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppConst.kRadius,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: BottomTile(
            text: text,
            text2: text2,
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
