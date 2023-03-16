import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../component/prescription_list_component.dart';
import '../main.dart';
import '../model/Prescription_Model.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel? userData;

  PatientDetailScreen({required this.userData});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;
  Future<List<PrescriptionModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tabController = TabController(length: 3, vsync: this);
    futureMethod();
  }

  void futureMethod() {
    future = prescriptionService.getPrescriptionByUser(widget.userData!.id);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  commonWidget(String? title, String? value) {
    return Column(
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.clip,
          text: TextSpan(
            text: '$title : ',
            style: secondaryTextStyle(),
            children: <TextSpan>[
              TextSpan(text: value.validate(), style: boldTextStyle()),
            ],
          ),
        ),
        16.height,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('${widget.userData!.fullName.validate()}', color: primaryColor, textColor: Colors.white),
      body: RefreshIndicator(
        onRefresh: () async {
          await 1.seconds.delay;
          futureMethod();
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonWidget('Name', widget.userData!.fullName.validate()),
            commonWidget('Age', widget.userData!.age),
            commonWidget('Gender', widget.userData!.gender.validate()),
            commonWidget('Height', widget.userData!.height),
            commonWidget('Weight', widget.userData!.weight),
            16.height,
            Text("Prescription List", style: boldTextStyle()),
            TabBar(
              indicatorColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: secondaryTextStyle(),
              labelColor: primaryColor,
              labelStyle: boldTextStyle(),
              controller: tabController,
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Active'),
                Tab(text: 'Rejected'),
              ],
            ),
            FutureBuilder<List<PrescriptionModel>>(
                future: future,
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data != null) {
                      List<PrescriptionModel> rejectedPrescription = [];
                      List<PrescriptionModel> approvePrescription = [];
                      List<PrescriptionModel> pendingPrescription = [];

                      snap.data!.forEach((element) {
                        if (element.status == '0') {
                          pendingPrescription.add(element);
                        } else if (element.status == '1') {
                          approvePrescription.add(element);
                        } else {
                          rejectedPrescription.add(element);
                        }
                      });

                      return SizedBox(
                        height: context.height(),
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            PrescriptionListComponent(
                              pendingPrescription,
                              voidCallBack: () async {
                                await 1.seconds.delay;
                                futureMethod();
                                appStore.setLoading(false);

                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 4, vertical: 8),
                            PrescriptionListComponent(
                              approvePrescription,
                              voidCallBack: () async {
                                await 1.seconds.delay;
                                futureMethod();
                                appStore.setLoading(false);

                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 4, vertical: 8),
                            PrescriptionListComponent(
                              rejectedPrescription,
                              voidCallBack: () async {
                                await 1.seconds.delay;
                                futureMethod();
                                appStore.setLoading(false);

                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 4, vertical: 8),
                          ],
                        ),
                      ).expand();
                    }
                  }
                  return snapWidgetHelper(snap, loadingWidget: Loader());
                })
          ],
        ).paddingAll(12),
      ),
    );
  }
}
