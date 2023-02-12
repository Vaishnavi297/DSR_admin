import 'package:dsr_admin/screens/splash_screen.dart';
import 'package:dsr_admin/services/UserServices.dart';
import 'package:dsr_admin/store/AppStore.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:dsr_admin/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppStore appStore = AppStore();
UserService userService = UserService();
CustomTheme appTheme = CustomTheme();
PageRouteAnimation? pageRouteAnimationGlobal;
Duration pageRouteTransitionDurationGlobal = Duration(milliseconds: 400);
late SharedPreferences sharedPreferences;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(behavior: SBehavior(), child: child!);
      },
      theme: ThemeData(
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: DefaultFont,
      ),
      home: SplashScreen(),
    );
  }
}

class SBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
