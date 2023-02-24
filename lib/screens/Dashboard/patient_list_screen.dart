import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/screens/patient_detail_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  Future<List<PatientModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = patientService.getAllPatient();
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
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: appBarWidget('Patient', showBack: false, color: primaryColor, textColor: white),
        body: FutureBuilder<List<PatientModel>>(
          future: future,
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data != null && snap.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snap.data!.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (c, i) {
                    return Divider(thickness: 1, height: 0, color: context.dividerColor);
                  },
                  itemBuilder: (context, i) {
                    PatientModel patientData = snap.data![i];

                    return Container(
                      decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.scaffoldBackgroundColor),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.height,
                          Text(patientData.fullName.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
                          8.height,
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: 'Age: ',
                              style: secondaryTextStyle(),
                              children: <TextSpan>[
                                TextSpan(text: patientData.age, style: boldTextStyle()),
                              ],
                            ),
                          ),
                          8.height,
                        ],
                      ),
                    ).onTap(() {
                      PatientDetailScreen(userData: patientData).launch(context);
                    });
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
