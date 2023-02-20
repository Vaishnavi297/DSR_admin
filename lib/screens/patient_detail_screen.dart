import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel? userData;

  PatientDetailScreen({required this.userData});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('${widget.userData!.fullName.validate()}'),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
