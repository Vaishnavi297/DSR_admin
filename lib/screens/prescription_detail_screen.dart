import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  final PrescriptionModel? data;

  PrescriptionDetailScreen({required this.data});

  @override
  _PrescriptionDetailScreenState createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {

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
      appBar: appBarWidget('${widget.data!.diseaseData!.name.validate()}',color: primaryColor,textColor: white),
    );
  }
}