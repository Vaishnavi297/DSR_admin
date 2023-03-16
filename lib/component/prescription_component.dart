import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../model/Prescription_Model.dart';
import '../screens/prescription_detail_screen.dart';
import '../utils/Common.dart';
import '../utils/cache_network_image.dart';

class PrescriptionComponent extends StatefulWidget {
  final PrescriptionModel? data;
  final VoidCallback? voidCallBack;

  PrescriptionComponent(this.data, {this.voidCallBack});

  @override
  _PrescriptionComponentState createState() => _PrescriptionComponentState();
}

class _PrescriptionComponentState extends State<PrescriptionComponent> {
  @override
  void initState() {
    super.initState();
  }

  void init() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.scaffoldBackgroundColor),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(tag: widget.data!.id.toString(), child: CachedImageWidget(url: widget.data!.url.validate(), height: 60, width: 60, radius: defaultRadius, fit: BoxFit.cover)),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: patientService.patientByUid(id: widget.data!.uid.validate()),
                    builder: (context, snapData) {
                      if (snapData.hasData) {
                        if (snapData.data != null && snapData.data!.isNotEmpty) {
                          return Text(snapData.data.validate(), style: primaryTextStyle()).expand();
                        }
                      }
                      return Offstage();
                    },
                  ),
                  8.width,
                  Text(
                    getStatus(status: widget.data!.status.validate()),
                    style: boldTextStyle(color: getStatusColor(status: widget.data!.status.validate()), size: 14),
                  )
                ],
              ),
              4.height,
              Text(widget.data!.diseaseData!.name.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
            ],
          ).expand(),
        ],
      ),
    ).onTap(() async {
      bool res = await PrescriptionDetailScreen(
        data: widget.data,
        voidCallBack: () {
          widget.voidCallBack?.call();
        },
      ).launch(context);
      if (res == true) {
        appStore.setLoading(true);
        widget.voidCallBack!();
        setState(() {});
      }
    }, hoverColor: Colors.transparent, splashColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
