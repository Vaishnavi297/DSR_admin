import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'Constant.dart';

InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? labelText, double? borderRadius, Color? fillColor, String? hintText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    hintText: hintText,
    hintStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: fillColor ?? context.dividerColor, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: true,
    fillColor: context.cardColor,
  );
}

userLoginData() async {
  if (appStore.isLoading) {
    await appStore.setUID(getStringAsync(UID), isInitializing: true);
    await appStore.setEmail(getStringAsync(USER_EMAIL), isInitializing: true);

    await appStore.setName(getStringAsync(NAME), isInitializing: true);
  }
}

getTimeStatus({int? status}) {
  if (status == 1) {
    return 'Morning';
  } else if (status == 2) {
    return 'Afternoon';
  } else if (status == 3) {
    return 'Evening';
  } else if (status == 4) {
    return 'Night';
  }
}

getStatus({String? status}) {
  if (status == '1') {
    return 'Active';
  } else if (status == '2') {
    return 'Reject';
  } else {
    return 'Pending';
  }
}

getStatusColor({String? status}) {
  if (status == '1') {
    return Colors.green;
  } else if (status == '0') {
    return primaryColor;
  } else {
    return Colors.red;
  }
}

Widget noDataWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.hourglass_empty,
        size: 45,
        color: textSecondaryColorGlobal,
      ),
      6.height,
      Text('No Data Found', style: primaryTextStyle()),
    ],
  ).center();
}
