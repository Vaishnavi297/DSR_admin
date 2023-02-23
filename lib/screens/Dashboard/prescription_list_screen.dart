import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/screens/prescription_detail_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return RefreshIndicator(
      onRefresh: () async {
        await 1.seconds.delay;
        init();
        setState(() {});
      },
      child: Scaffold(
        appBar: appBarWidget('Prescription', showBack: false, color: primaryColor, textColor: white),
        body: FutureBuilder<List<PrescriptionModel>>(
          future: future,
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
                          CachedImageWidget(url: data.url.validate(), height: 40, width: 40, radius: defaultRadius, fit: BoxFit.cover),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                future: patientService.patientByUid(id: data.uid.validate()),
                                builder: (context, snapData) {
                                  if (snapData.hasData) {
                                    if (snapData.data != null && snapData.data!.isNotEmpty) {
                                      return Text(snapData.data.validate(), style: boldTextStyle());
                                    }
                                  }
                                  return Offstage();
                                },
                              ),
                              4.height,
                              Text(data.diseaseData!.name.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
                            ],
                          ),
                        ],
                      ),
                    ).onTap(() {
                      PrescriptionDetailScreen(data: data).launch(context);
                    }, hoverColor: Colors.transparent, splashColor: Colors.transparent, highlightColor: Colors.transparent);
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
