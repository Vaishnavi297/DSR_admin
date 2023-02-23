import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrescriptionListScreen extends StatefulWidget {
  @override
  _PrescriptionListScreenState createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Prescription', showBack: false, color: primaryColor, textColor: white),
      body: FutureBuilder<List<PrescriptionModel>>(
        future: prescriptionService.getAllPrescription(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data != null && snap.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snap.data!.length,
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, i) {
                  PrescriptionModel data = snap.data![i];

                  return Container(
                    decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.scaffoldBackgroundColor),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        CachedImageWidget(url: data.url.validate(), height: 40,width: 40,radius: defaultRadius),
                        16.width,
                        Text(data.diseaseData!.name.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
                      ],
                    ),
                  );
                },
              );
            }
          }
          return snapWidgetHelper(snap, loadingWidget: Loader());
        },
      ),
    );
  }
}
