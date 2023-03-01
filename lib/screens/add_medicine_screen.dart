import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class AddMedicineScreen extends StatefulWidget {
  final PrescriptionModel? data;
  final MedicineModel? medicineModel;
  final bool? isUpdate;

  AddMedicineScreen({required this.data, this.isUpdate = false, this.medicineModel});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  TextEditingController medicineNameCont = TextEditingController();

  List<MedicineTiming> timingList = [];
  final List<MedicineTiming> selectedTiming = [];
  List<MedicineTimingModel> selectedTime = [];

  bool beforeEating = false;
  num? beforeEat = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    timingList.add(MedicineTiming(name: MORNING, isSelected: false, value: 1));
    timingList.add(MedicineTiming(name: AFTER_NOON, isSelected: false, value: 2));
    timingList.add(MedicineTiming(name: EVENING, isSelected: false, value: 3));
    timingList.add(MedicineTiming(name: NIGHT, isSelected: false, value: 4));

    if (widget.isUpdate.validate()) {
      medicineNameCont.text = widget.medicineModel!.name.validate();
      beforeEat = widget.medicineModel!.eatingStatus.validate();
      beforeEating = beforeEat == 1 ? true : false;

      timingList.forEach((e1) {
        widget.medicineModel!.timing.validate().forEach((e2) {
          if (e1.value == e2.value) {
            selectedTiming.add(e1);
            e1.isSelected = true;
          } else if (e1.value == e2.value) {
            selectedTiming.add(e1);
            e1.isSelected = true;
          } else if (e1.value == e2.value) {
            selectedTiming.add(e1);
            e1.isSelected = true;
          } else if (e1.value == e2.value) {
            selectedTiming.add(e1);
            e1.isSelected = true;
          } else {
            //
          }
        });
      });
    }

    setState(() {});
  }

  // region Add Medicine
  Future<void> addMedicine() async {
    appStore.setLoading(true);
    hideKeyboard(context);

    selectedTime.clear();
    selectedTiming.forEach((element) {
      MedicineTimingModel medicine = MedicineTimingModel();
      medicine.status = 0;
      medicine.value = element.value;
      selectedTime.add(medicine);
    });

    MedicineModel data = MedicineModel();

    data.name = medicineNameCont.text.validate();
    data.timing = selectedTime;
    data.eatingStatus = beforeEat;
    data.createdAt = DateTime.now().toString();
    data.updatedAt = DateTime.now().toString();

    if (widget.isUpdate.validate()) {
      data.id = widget.medicineModel!.id;
      medicineService.updateMedicine(widget.data!.id.validate(), data).then((value) {
        finish(context, true);
      });
    } else {
      medicineService.addPrescription(widget.data!.id.validate(), data).then((value) {
        finish(context, true);
      });
    }
  }

  // endregion

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.isUpdate.validate() ? "Update Medicine" : 'Add Medicine', color: primaryColor, textColor: white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  controller: medicineNameCont,
                  decoration: inputDecoration(context, labelText: 'Medicine', hintText: 'Enter Medicine Name'),
                ),
                16.height,
                Text('Select Medicine Time', style: secondaryTextStyle(size: 16)),
                16.height,
                Container(
                  decoration: boxDecorationWithRoundedCorners(border: Border.all(color: context.dividerColor), backgroundColor: context.scaffoldBackgroundColor),
                  child: AnimatedListView(
                    itemCount: timingList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) {
                      MedicineTiming data = timingList[i];

                      return CheckboxListTile(
                        contentPadding: EdgeInsets.only(right: 8),
                        value: selectedTiming.contains(data),
                        title: Text(data.name.validate(), style: primaryTextStyle()).paddingLeft(16),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: primaryColor,
                        dense: true,
                        onChanged: (bool? isChecked) {
                          if (isChecked!) {
                            selectedTiming.add(data);
                          } else {
                            selectedTiming.remove(data);
                          }
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                16.height,
                CheckboxListTile(
                  value: beforeEating,
                  contentPadding: EdgeInsets.only(right: 8),
                  title: Text('Eating Status', style: primaryTextStyle()).paddingLeft(16),
                  activeColor: primaryColor,
                  dense: true,
                  onChanged: (v) {
                    beforeEating = !beforeEating;
                    if (v == true) {
                      beforeEat = 1;
                    } else {
                      beforeEat = 0;
                    }
                    setState(() {});
                  },
                ),
                16.height,
                AppButton(
                  child: Text(widget.isUpdate.validate() ? 'Update' : 'Add', style: boldTextStyle(color: white)),
                  color: primaryColor,
                  width: context.width(),
                  onTap: () {
                    addMedicine();
                  },
                )
              ],
            ),
          ),
          Observer(builder: (context) {
            return Loader().visible(appStore.isLoading);
          })
        ],
      ),
    );
  }
}
