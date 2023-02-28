import 'package:dsr_admin/component/prescription_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/Prescription_Model.dart';
import '../utils/Common.dart';

class PrescriptionListComponent extends StatefulWidget {
  final List<PrescriptionModel>? prescriptionList;

  PrescriptionListComponent(this.prescriptionList);

  @override
  _PrescriptionListComponentState createState() => _PrescriptionListComponentState();
}

class _PrescriptionListComponentState extends State<PrescriptionListComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.prescriptionList!.isNotEmpty
        ? AnimatedListView(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.prescriptionList!.length,
            itemBuilder: (c, i) {
              return PrescriptionComponent(widget.prescriptionList![i]).paddingSymmetric(vertical: 8);
            })
        : noDataWidget();
  }
}
