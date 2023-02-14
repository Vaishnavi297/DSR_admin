import 'package:dsr_admin/utils/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'disease_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        'Dashboard',
        showBack: false,
        actions: [
          TextButton(
            onPressed: () {
              DiseaseScreen().launch(context);
            },
            child: Text('Disease', style: primaryTextStyle()),
          ),
        ],
      ),
    );
  }
}
