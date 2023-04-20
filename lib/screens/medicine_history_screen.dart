import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/MedicineHistoryModel.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';

class MedicineHistoryScreen extends StatefulWidget {
  final MedicineModel? medicineModel;

  MedicineHistoryScreen({this.medicineModel});

  @override
  State<MedicineHistoryScreen> createState() => _MedicineHistoryScreenState();
}

class _MedicineHistoryScreenState extends State<MedicineHistoryScreen> {
  Future<List<MedicineHistoryModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = medicineHistoryService.getAllMedicineHistory(widget.medicineModel!.id.validate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.medicineModel!.name.validate(), color: primaryColor, textColor: white),
      body: FutureBuilder<List<MedicineHistoryModel>>(
        future: future,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data != null && snap.data!.isNotEmpty) {
              return AnimatedListView(
                itemCount: snap.data!.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    width: context.width(),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTimeStatus(status: snap.data![i].timingStatus.validate()), style: primaryTextStyle()),
                            Text(snap.data![i].date.validate(), style: secondaryTextStyle()),
                          ],
                        ),
                        snap.data![i].isMissed.validate() ? Icon(Icons.close, color: Colors.red) : Icon(Icons.check, color: Colors.green)
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
    );
  }
}
