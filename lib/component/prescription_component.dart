import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/Prescription_Model.dart';
import '../screens/prescription_detail_screen.dart';
import '../utils/cache_network_image.dart';

class PrescriptionComponent extends StatefulWidget {
  final PrescriptionModel? data;

  PrescriptionComponent(this.data);

  @override
  _PrescriptionComponentState createState() => _PrescriptionComponentState();
}

class _PrescriptionComponentState extends State<PrescriptionComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.scaffoldBackgroundColor),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedImageWidget(url: widget.data!.url.validate(), height: 60, width: 60, radius: defaultRadius, fit: BoxFit.cover),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: patientService.patientByUid(id: widget.data!.uid.validate()),
                builder: (context, snapData) {
                  if (snapData.hasData) {
                    if (snapData.data != null && snapData.data!.isNotEmpty) {
                      return Text(snapData.data.validate(), style: primaryTextStyle());
                    }
                  }
                  return Offstage();
                },
              ),
              4.height,
              Text(widget.data!.diseaseData!.name.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
            ],
          ),
        ],
      ),
    ).onTap(() {
      PrescriptionDetailScreen(data: widget.data).launch(context);
    }, hoverColor: Colors.transparent, splashColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
