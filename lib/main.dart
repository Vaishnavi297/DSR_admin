import 'package:dsr_admin/screens/splash_screen.dart';
import 'package:dsr_admin/services/AuthServices.dart';
import 'package:dsr_admin/services/DiseaseService.dart';
import 'package:dsr_admin/services/adminServices.dart';
import 'package:dsr_admin/services/patientServices.dart';
import 'package:dsr_admin/store/AppStore.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:dsr_admin/utils/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();
AdminService userService = AdminService();
DiseaseService diseaseService = DiseaseService();
CustomTheme appTheme = CustomTheme();
AuthService authService = AuthService();
PatientService patientService = PatientService();

Duration pageRouteTransitionDurationGlobal = Duration(milliseconds: 400);
late SharedPreferences sharedPreferences;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultRadius = 12;
  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;
  defaultAppButtonElevation = 0;
  pageRouteTransitionDurationGlobal = 400.milliseconds;

  await initialize();
  await appStore.setLogin(getBoolAsync(IS_LOGGED_IN), isInitializing: true);
  userLoginData();

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
        fontFamily: GoogleFonts.workSans().fontFamily,
        useMaterial3: true,
        textTheme: GoogleFonts.workSansTextTheme(),
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
