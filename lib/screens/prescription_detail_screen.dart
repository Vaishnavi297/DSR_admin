import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/screens/add_medicine_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  final PrescriptionModel? data;

  PrescriptionDetailScreen({required this.data});

  @override
  _PrescriptionDetailScreenState createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  PrescriptionModel? prescriptionData;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    getPrescriptionData();
  }

  Future<void> getPrescriptionData() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        '${widget.data!.diseaseData!.name.validate()}',
        color: primaryColor,
        textColor: white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prescription', style: boldTextStyle(size: 20)),
            16.height,
            Container(
              decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
              child: CachedImageWidget(url: widget.data!.url.validate(), height: context.height() * 0.4, width: context.width(), radius: defaultRadius, fit: BoxFit.cover),
            ),
            16.height,
            Text('Medicines', style: boldTextStyle(size: 20)),
            8.height,
            AnimatedListView(
              itemCount: 12,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return Container(
                  height: 50,
                  width: context.width(),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () async {
          bool? res = await AddMedicineScreen(data: widget.data!).launch(context);
          if (res ?? false) {
            init();
          }
        },
        label: Text(
          'Add Medicine',
          style: boldTextStyle(color: white),
        ),
      ),
    );
  }
}
