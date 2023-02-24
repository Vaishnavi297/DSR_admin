import 'package:dsr_admin/model/Disease_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import '../../utils/Common.dart';

class DiseaseScreen extends StatefulWidget {
  @override
  _DiseaseScreenState createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  TextEditingController diseaseCont = TextEditingController();

  Future<List<DiseaseModel>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = diseaseService.getAllDisease();
  }

  /// region Add/update disease
  addDiseaseWidget({bool? isUpdate = false, String? id}) {
    return showConfirmDialogCustom(
      context,
      title: '',
      barrierDismissible: false,
      customCenterWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(isUpdate.validate() ? "Update Disease" : "Add Disease", style: boldTextStyle()).paddingLeft(16),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  finish(context);
                },
              ),
            ],
          ),
          16.height,
          AppTextField(
            controller: diseaseCont,
            decoration: inputDecoration(context, labelText: 'Enter disease name'),
            textFieldType: TextFieldType.OTHER,
          ).paddingSymmetric(horizontal: 12),
        ],
      ),
      positiveText: isUpdate.validate() ? "Update" : 'Add',
      onAccept: (v) {
        DiseaseModel diseaseModel = DiseaseModel();
        diseaseModel.id = isUpdate == true ? id : '';
        diseaseModel.name = diseaseCont.text.trim();
        if (!isUpdate.validate()) {
          diseaseService.addDisease(diseaseModel).then((value) {
            setState(() {});

            toast('Added Successfully');
          });
        } else {
          diseaseService.updateDisease(id: id, data: diseaseModel).then((value) {
            setState(() {});

            toast('Updated Successfully');
          });
        }
        setState(() {});
      },
    );
  }
  ///endregion

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await 1.seconds.delay;
        init();
        setState(() {});
      },
      child: Scaffold(
        appBar: appBarWidget('Disease', showBack: false, color: primaryColor, textColor: white),
        body: FutureBuilder<List<DiseaseModel>>(
          future: future,
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
                    DiseaseModel diseaseData = snap.data![i];
                    return Slidable(
                      key: ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (v) {
                              diseaseCont.text = diseaseData.name.toString();
                              addDiseaseWidget(isUpdate: true, id: diseaseData.id.validate());
                            },
                            backgroundColor: Colors.black12,
                            foregroundColor: Colors.black,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (v) {
                              showConfirmDialogCustom(context, title: 'Are you sure want to delete Disease?', onAccept: (v) {
                                diseaseService.deleteDisease(id: diseaseData.id).then((value) {
                                  setState(() {});
                                  toast('Delete Successfully');
                                });
                                setState(() {});
                              });
                            },
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.redAccent,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(title: Text(diseaseData.name.validate(), style: boldTextStyle())),
                    );
                  },
                );
              }
            }
            return snapWidgetHelper(snap, loadingWidget: Loader());
          },
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(4),
          decoration: boxDecorationWithRoundedCorners(borderRadius: radius(38), backgroundColor: primaryColor),
          child: IconButton(
            onPressed: () {
              diseaseCont.text = '';
              addDiseaseWidget();
            },
            icon: Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}