import 'package:flutter/material.dart';

import '../main.dart';

class CustomButton extends StatelessWidget {
  final Function onButtonClick;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isDisabled;
  final double? height;

  const CustomButton({required this.onButtonClick, required this.buttonText, this.buttonTextStyle, this.backgroundColor, this.borderRadius, this.isDisabled = false, this.height});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled!,
      child: MaterialButton(
        onPressed: () {
          onButtonClick();
        },
        height: height ?? 45,
        minWidth: MediaQuery.of(context).size.width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: !isDisabled! ? (backgroundColor ?? appTheme.colorPrimary) : appTheme.colorPrimary.withOpacity(0.5),
        child: Text(buttonText, style: buttonTextStyle ?? appTheme.primaryTextStyle()),
      ),
    );
  }
}
