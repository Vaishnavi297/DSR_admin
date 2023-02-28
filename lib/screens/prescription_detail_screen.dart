import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/screens/add_medicine_screen.dart';
import 'package:dsr_admin/screens/zoom_image_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/Medicine_Model.dart';
import '../utils/Common.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  final PrescriptionModel? data;

  PrescriptionDetailScreen({required this.data});

  @override
  _PrescriptionDetailScreenState createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  PrescriptionModel? prescriptionData;
  Future<List<MedicineModel>>? future;

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
    return Scaffold(
      appBar: appBarWidget('${widget.data!.diseaseData!.name.validate()}', color: primaryColor, textColor: white),
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
              ZoomImageScreen(widget.data!.url.validate(),widget.data!.id.toString()).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
            }),
            16.height,
            Text('Medicines', style: boldTextStyle(size: 20)),
            8.height,
            FutureBuilder<List<MedicineModel>>(
              future: future,
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data != null && snap.data!.isNotEmpty) {
                    return AnimatedListView(
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
                                  bool? res = await AddMedicineScreen(data: widget.data!, medicineModel: snap.data![i], isUpdate: true).launch(context);
                                  if (res == true) {
                                    init();
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.edit, size: 22),
                              ),
                              IconButton(
                                onPressed: () async {
                                  showConfirmDialogCustom(context,title: 'Are you sure want to remove this medicine?',positiveText: 'Delete',negativeText: 'Cancel', onAccept: (v) async {
                                    await medicineService.deleteMedicine(id: widget.data!.id, data: snap.data![i]).then((value) {
                                      init();
                                      setState(() {});
                                    });
                                  });
                                },
                                icon: Icon(Icons.delete_sharp, size: 22),
                              ),
                            ],
                          ),
                        );
                      },
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
          bool? res = await AddMedicineScreen(data: widget.data!).launch(context);
          if (res ?? false) {
            init();
            setState(() {});
          }
        },
        label: Text('Add Medicine', style: boldTextStyle(color: white)),
      ),
    );
  }
}
