import 'package:dsr_admin/screens/splash_screen.dart';
import 'package:dsr_admin/services/AuthServices.dart';
import 'package:dsr_admin/services/DiseaseService.dart';
import 'package:dsr_admin/services/MedicineHistoryService.dart';
import 'package:dsr_admin/services/MedicineService.dart';
import 'package:dsr_admin/services/PrescriptionServices.dart';
import 'package:dsr_admin/services/AdminServices.dart';
import 'package:dsr_admin/services/PatientServices.dart';
import 'package:dsr_admin/store/AppStore.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();
AdminService userService = AdminService();
DiseaseService diseaseService = DiseaseService();
AuthService authService = AuthService();
PatientService patientService = PatientService();
PrescriptionService prescriptionService = PrescriptionService();
MedicineService medicineService = MedicineService();
MedicineHistoryService medicineHistoryService = MedicineHistoryService();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  Firebase.initializeApp();

  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultRadius = 12;
  pageRouteTransitionDurationGlobal = 400.milliseconds;

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
