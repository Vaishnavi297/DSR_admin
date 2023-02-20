import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/screens/patient_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Patient', showBack: false),
      body: FutureBuilder<List<PatientModel>>(
        future: patientService.getAllPatient(),
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
                    decoration: boxDecorationWithRoundedCorners(),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        16.height,
                        Text(patientData.fullName.validate(), style: boldTextStyle()),
                        16.height,
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: 'Age: ',
                            style: secondaryTextStyle(),
                            children: <TextSpan>[
                              TextSpan(text: patientData.age.validate(), style: boldTextStyle()),
                            ],
                          ),
                        ),
                        16.height,
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
    );
  }
}
