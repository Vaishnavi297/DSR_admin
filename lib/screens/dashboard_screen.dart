import 'package:dsr_admin/screens/Dashboard/home_screen.dart';
import 'package:dsr_admin/screens/Dashboard/prescription_list_screen.dart';
import 'package:dsr_admin/screens/Dashboard/user_list_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Dashboard/disease_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeScreen(),
    DiseaseScreen(),
    PatientListScreen(),
    PrescriptionListScreen(),
  ];

  Widget activeWidget(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: primaryColor.withOpacity(0.3), borderRadius: radius(defaultRadius)),
      child: Column(
        children: [
          Text(text.validate(), style: primaryTextStyle(size: 14, color: Colors.white)),
          Icon(Entypo.dot_single),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          currentIndex = i;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: activeWidget('Home'),
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            activeIcon: activeWidget('Disease'),
            label: '',
            icon: Icon(Icons.coronavirus),
          ),
          BottomNavigationBarItem(
            activeIcon: activeWidget('Users'),
            label: '',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            activeIcon: activeWidget('Prescription'),
            label: '',
            icon: Icon(Icons.article),
          )
        ],
      ),
    );
  }
}
