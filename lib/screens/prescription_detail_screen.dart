import 'package:dsr_admin/component/app_common_dialog.dart';
import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/screens/add_medicine_screen.dart';
import 'package:dsr_admin/screens/reason_dialog_component.dart';
import 'package:dsr_admin/screens/zoom_image_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/Medicine_Model.dart';
import '../utils/Common.dart';
import 'medicine_history_screen.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  final PrescriptionModel? data;
  final VoidCallback? voidCallBack;

  PrescriptionDetailScreen({required this.data, this.voidCallBack});

  @override
  _PrescriptionDetailScreenState createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  PrescriptionModel? prescriptionData;
  Future<List<MedicineModel>>? future;
  bool? isUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = medicineService.getAllMedicine(widget.data!.id.validate());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        log(isUpdate);
        finish(context, isUpdate);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBarWidget(
          '${widget.data!.diseaseData!.name.validate()}',
          color: primaryColor,
          textColor: white,
          backWidget: BackButton(
              onPressed: () {
                finish(context, isUpdate);
              },
              color: Colors.white),
          actions: [
            if (widget.data!.status == "0")
              TextButton(
                child: Text('Reject', style: boldTextStyle(color: white)),
                onPressed: () {
                  showInDialog(
                    context,
                    contentPadding: EdgeInsets.zero,
                    builder: (context) {
                      return AppCommonDialog(
                        title: 'Rejected Reason',
                        child: ReasonDialog(
                          data: widget.data,
                          voidCallBack: () {
                            isUpdate = true;
                            widget.voidCallBack?.call();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prescription', style: boldTextStyle(size: 20)),
              16.height,
              Container(
                decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
                child: Hero(
                    tag: widget.data!.id.toString(),
                    child: CachedImageWidget(url: widget.data!.url.validate(), height: context.height() * 0.4, width: context.width(), radius: defaultRadius, fit: BoxFit.cover)),
              ).onTap(() {
                ZoomImageScreen(widget.data!.url.validate(), widget.data!.id.toString()).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
              }),
              16.height,
              FutureBuilder<List<MedicineModel>>(
                future: future,
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data != null && snap.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Medicines', style: boldTextStyle(size: 20)),
                          8.height,
                          AnimatedListView(
                            itemCount: snap.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              return Container(
                                padding: EdgeInsets.only(left: 16),
                                width: context.width(),
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
                                child: Row(
                                  children: [
                                    Text(snap.data![i].name.validate(), style: primaryTextStyle()),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        MedicineHistoryScreen(medicineModel: snap.data![i]).launch(context);
                                      },
                                      icon: Icon(Icons.remove_red_eye_outlined, size: 22),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (widget.data!.status == "2") {
                                          toast("You can't edit medicine because this prescription is rejected");
                                        } else {
                                          bool? res = await AddMedicineScreen(data: widget.data!, medicineModel: snap.data![i], isUpdate: true).launch(context);
                                          if (res == true) {
                                            init();
                                            setState(() {});
                                          }
                                        }
                                      },
                                      icon: Icon(Icons.edit, size: 22),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (widget.data!.status == "2") {
                                          toast("You can't delete medicine because this prescription is rejected");
                                        } else {
                                          showConfirmDialogCustom(context, title: 'Are you sure want to remove this medicine?', positiveText: 'Delete', negativeText: 'Cancel', onAccept: (v) async {
                                            await medicineService.deleteMedicine(id: widget.data!.id, data: snap.data![i]).then((value) {
                                              init();
                                              setState(() {});
                                            });
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.delete_sharp, size: 22),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    if (snap.data == null && snap.data!.isEmpty) noDataWidget();
                  }
                  return snapWidgetHelper(snap, loadingWidget: Loader());
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () async {
            if (widget.data!.status == "2") {
              toast("You can't add medicine because this prescription is rejected");
            } else {
              bool? res = await AddMedicineScreen(data: widget.data!).launch(context);
              if (res ?? false) {
                init();
                isUpdate = true;
                setState(() {});
              }
            }
          },
          label: Text('Add Medicine', style: boldTextStyle(color: white)),
        ),
      ),
    );
  }
}
