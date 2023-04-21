import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/services/MedicineHistoryService.dart';
import 'package:dsr_admin/services/MedicineService.dart';
import 'package:dsr_admin/services/PatientServices.dart';
import 'package:dsr_admin/services/PrescriptionServices.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../component/prescription_list_component.dart';
import '../main.dart';
import '../model/Prescription_Model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel? userData;

  PatientDetailScreen({required this.userData});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with SingleTickerProviderStateMixin {
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

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoad,
      progressIndicator: Loader(),
      child: Scaffold(
        appBar: appBarWidget('${widget.userData!.fullName.validate()}',
            color: primaryColor,
            textColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  showConfirmDialogCustom(context,
                      title: 'Are you sure want to remove this User?',
                      positiveText: 'Delete',
                      negativeText: 'Cancel', onAccept: (v) async {
                    onDeletePress();
                  });
                },
                icon: Icon(Icons.delete),
                color: Colors.white,
              )
            ]),
        body: RefreshIndicator(
          onRefresh: () async {
            await 1.seconds.delay;
            futureMethod();
            setState(() {});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getPatientDetailsView(),
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
      ),
    );
  }

  Future onDeletePress() async {
    setState(() {
      isLoad = true;
    });
    var userId = widget.userData!.id.toString();
    var patientService = PatientService();
    var medicineServices = MedicineService();
    var medicineHistoryService = MedicineHistoryService();
    var userPrescriptionList =
        await prescriptionService.getPrescriptionByUser(userId);
    var medicineList = await medicineServices.getAllMedicineByIdList(
        userPrescriptionList.map((e) => e.id!).toList());
    await medicineHistoryService.deleteMedicineByMedicineIdList(
        medicineList.map((e) => e.id!).toList());
    await medicineServices.deleteMedicineByMedicineIdList(
        userPrescriptionList.map((e) => e.id!).toList());
    await prescriptionService.deletePrescriptionByUser(userId);
    await patientService.deletePatient(id: userId);
    setState(() {
      isLoad = false;
    });
    Navigator.of(context).pop(true);
  }

  Widget getPatientDetailsView() {
    if (widget.userData != null) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1.5),
                    image: DecorationImage(
                        image: AssetImage(
                      widget.userData!.gender!.toLowerCase() == "male"
                          ? ic_male
                          : ic_female,
                    ))),
              ),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userData!.fullName!,
                    style: boldTextStyle(),
                  ),
                  Text(
                    "Age: ${widget.userData!.age!.toString()}",
                    style: primaryTextStyle(),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          String url =
                              "tel:${widget.userData!.mobileNumber.toString()}";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          Icons.call,
                          size: 20,
                          color: Colors.white,
                        ),
                        color: context.primaryColor.withOpacity(0.9),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      20.width,
                      MaterialButton(
                        onPressed: () async {
                          String url =
                              "sms:${widget.userData!.mobileNumber.toString()}?body=Hi%20${widget.userData!.fullName}\n\n";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          Icons.message,
                          size: 20,
                          color: Colors.white,
                        ),
                        color: context.primaryColor.withOpacity(0.9),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          20.height,
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor, width: 1.5)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Height",
                      ),
                      Text(
                        "${widget.userData!.height.toString()} Cm",
                      ),
                    ],
                  ),
                ),
              ),
              20.width,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor, width: 1.5)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Weight",
                      ),
                      Text(
                        "${widget.userData!.weight.toString()} Kg",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
