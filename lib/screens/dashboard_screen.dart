import 'package:dsr_admin/screens/Dashboard/home_screen.dart';
import 'package:dsr_admin/screens/Dashboard/prescription_list_screen.dart';
import 'package:dsr_admin/screens/Dashboard/patient_list_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import 'Dashboard/disease_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> tabs = [
    HomeScreen(),
    DiseaseScreen(),
    PatientListScreen(),
    PrescriptionListScreen(),
  ];

  Widget activeWidget(String text) {
    return Text(text.validate(), style: boldTextStyle(size: 14, color: primaryColor));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: tabs[appStore.currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          onTap: (i) {
            appStore.currentIndex = i;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: context.cardColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: primaryColor,
          currentIndex: appStore.currentIndex,
          items: [
            BottomNavigationBarItem(activeIcon: activeWidget('Home'), label: '', icon: Icon(Icons.home)),
            BottomNavigationBarItem(activeIcon: activeWidget('Disease'), label: '', icon: Icon(Icons.coronavirus)),
            BottomNavigationBarItem(activeIcon: activeWidget('Patients'), label: '', icon: Icon(Icons.person)),
            BottomNavigationBarItem(activeIcon: activeWidget('Prescription'), label: '', icon: Icon(Icons.article))
          ],
        ),
      ),
    );
  }
}
