import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppCommonDialog extends StatelessWidget {
  final String title;
  final Widget child;

  AppCommonDialog({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          width: context.width(),
          decoration: boxDecorationDefault(
            color: primaryColor,
            borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
          ),
          child: Row(
            children: [
              Text(title, style: boldTextStyle(color: Colors.white)).expand(),
              CloseButton(color: Colors.white),
            ],
          ),
        ),
        16.height,
        child,
      ],
    );
  }
}
