import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/screens/prescription_detail_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/prescription_component.dart';

class PrescriptionListScreen extends StatefulWidget {
  @override
  _PrescriptionListScreenState createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  Future<List<PrescriptionModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = prescriptionService.getAllPrescription();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Prescription', showBack: false, color: primaryColor, textColor: white),
      body: RefreshIndicator(
        onRefresh: () async {
          await 1.seconds.delay;
          init();
          setState(() {});
        },
        child: FutureBuilder<List<PrescriptionModel>>(
          future: future,
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data != null && snap.data!.isNotEmpty) {
                return AnimatedListView(
                  itemCount: snap.data!.length,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, i) {
                    PrescriptionModel data = snap.data![i];

                    return PrescriptionComponent(data).paddingSymmetric(vertical: 8, horizontal: 16);
                  },
                );
              }
            }
            return snapWidgetHelper(snap, loadingWidget: Loader());
          },
        ),
      ),
    );
  }
}
