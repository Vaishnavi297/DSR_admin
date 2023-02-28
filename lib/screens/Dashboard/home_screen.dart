import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/screens/dashboard_screen.dart';
import 'package:dsr_admin/screens/sign_in_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../component/home_card_component.dart';
import '../../component/prescription_component.dart';
import '../../model/Prescription_Model.dart';
import '../../utils/Constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? patientCount = 0;
  int? prescriptionCount = 0;

  @override
  void initState() {
    prescriptionService.getAllPrescriptionLength().then((value) {
      prescriptionCount = value;
      setState(() {});
    });
    patientService.getAllPatientLength().then((value) {
      patientCount = value;
      setState(() {});
    });
    super.initState();
  }

  logOut() {
    showConfirmDialogCustom(context, barrierDismissible: false, title: 'Are you sure want to log out?', onAccept: (e) {
      appStore.setUID('');
      appStore.setEmail('');
      appStore.setName('');
      appStore.setLogin(false);

      SignInScreen().launch(context, isNewTask: true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        '',
        showBack: false,
        titleWidget: RichText(
          maxLines: 1,
          overflow: TextOverflow.clip,
          text: TextSpan(
            text: 'Hello, ',
            style: secondaryTextStyle(color: Colors.white),
            children: <TextSpan>[
              TextSpan(text: getStringAsync(NAME).capitalizeFirstLetter(), style: boldTextStyle(color: Colors.white)),
            ],
          ),
        ),
        color: primaryColor,
        textColor: white,
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HomeCardComponent(count: patientCount.toString(), icon: Icon(Icons.person, color: primaryColor), title: "Patients").onTap(() {
                  appStore.currentIndex = 2;
                  DashboardScreen().launch(context);
                  setState(() {});
                }, hoverColor: Colors.transparent, highlightColor: transparentColor, splashColor: Colors.transparent),
                16.width,
                HomeCardComponent(count: prescriptionCount.toString(), icon: Icon(Icons.article_rounded, color: primaryColor), title: 'Prescriptions').onTap(() {
                  appStore.currentIndex = 3;
                  DashboardScreen().launch(context);
                  setState(() {});
                }, hoverColor: Colors.transparent, highlightColor: transparentColor, splashColor: Colors.transparent),
              ],
            ),
            30.height,
            Text("Prescription List", style: boldTextStyle()),
            Divider(endIndent: 250),
            8.height,
            FutureBuilder<List<PrescriptionModel>>(
              future: prescriptionService.getAllPrescription(),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data != null && snap.data!.isNotEmpty) {
                    return AnimatedListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snap.data!.length >= 10 ? 100 : snap.data!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        PrescriptionModel data = snap.data![i];

                        return PrescriptionComponent(data).paddingSymmetric(vertical: 8);
                      },
                    );
                  }
                }
                return snapWidgetHelper(snap, loadingWidget: Loader());
              },
            ),
          ],
        ),
      ),
    );
  }
}
