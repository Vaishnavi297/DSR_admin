import 'package:dsr_admin/screens/sign_in_screen.dart';
import 'package:dsr_admin/utils/widgetExtention.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/Constant.dart';
import '../utils/Images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(seconds: 2)).then((value) => SignInScreen().launch(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ic_app_logo, height: 150, width: 150),
            SizedBox(height: 16),
            Text(AppName, style: appTheme.boldTextStyle()),
          ],
        ),
      ),
    );
  }
}
