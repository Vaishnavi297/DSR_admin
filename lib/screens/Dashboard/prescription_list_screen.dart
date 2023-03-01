import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../component/prescription_component.dart';
import '../../component/prescription_list_component.dart';

class PrescriptionListScreen extends StatefulWidget {
  @override
  _PrescriptionListScreenState createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> with SingleTickerProviderStateMixin {
  Future<List<PrescriptionModel>>? future;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    tabController = TabController(length: 3, vsync: this);
    futureMethod();
  }

  void futureMethod() {
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
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
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
                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 16, vertical: 8),
                            PrescriptionListComponent(
                              approvePrescription,
                              voidCallBack: () async {
                                await 1.seconds.delay;
                                futureMethod();
                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 16, vertical: 8),
                            PrescriptionListComponent(
                              rejectedPrescription,
                              voidCallBack: () async {
                                await 1.seconds.delay;
                                futureMethod();
                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 16, vertical: 8),
                          ],
                        ),
                      ).expand();
                    }
                  }
                  return snapWidgetHelper(snap, loadingWidget: Loader());
                })
          ],
        ),

        // child: FutureBuilder<List<PrescriptionModel>>(
        //   future: future,
        //   builder: (context, snap) {
        //     if (snap.hasData) {
        //       if (snap.data != null && snap.data!.isNotEmpty) {
        //         return AnimatedListView(
        //           itemCount: snap.data!.length,
        //           padding: EdgeInsets.symmetric(vertical: 16),
        //           itemBuilder: (context, i) {
        //             PrescriptionModel data = snap.data![i];
        //
        //             return PrescriptionComponent(data).paddingSymmetric(vertical: 8, horizontal: 16);
        //           },
        //         );
        //       }
        //     }
        //     return snapWidgetHelper(snap, loadingWidget: Loader());
        //   },
        // ),
      ),
    );
  }
}
