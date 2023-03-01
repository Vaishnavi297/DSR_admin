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
  TextEditingController searchCont = TextEditingController();

  FocusNode searchFocus = FocusNode();
  List<DiseaseModel> disease = [];
  List<DiseaseModel> searchList = [];

  Future<List<DiseaseModel>>? future;
  List<DiseaseModel>? diseaseList = [];

  bool? isSearch = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = diseaseService.getAllDisease();
    200.milliseconds.delay.then((value) => context.requestFocus(searchFocus));
    loadDisease();
  }

  void loadDisease() {
    diseaseService.getAllDisease().then((value) {
      log(value);
      disease = value;
      if (searchCont.text.isNotEmpty) {
        searchList.clear();
        for (int i = 0; i <= searchCont.text.length; i++) {
          String data = disease[i].name.validate();
          if (data.toLowerCase().contains(searchCont.text.toLowerCase())) {
            searchList.add(disease[i]);
            setState(() {});
          }
        }
      }
    }).catchError((e) {
      log(e);
    });
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
    return Scaffold(
      appBar: appBarWidget('Disease', showBack: false, color: primaryColor, textColor: white),
      body: RefreshIndicator(
        onRefresh: () async {
          await 1.seconds.delay;
          init();
          setState(() {});
        },
        child: FutureBuilder<List<DiseaseModel>>(
          future: future,
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data != null && snap.data!.isNotEmpty) {
                diseaseList = snap.data!;
                return Column(
                  children: [
                    AppTextField(
                      controller: searchCont,
                      decoration: inputDecoration(context, prefixIcon: Icon(Icons.search), labelText: 'Search Disease'),
                      textFieldType: TextFieldType.EMAIL,
                      errorThisFieldRequired: 'This field is required',
                      autoFillHints: [AutofillHints.email],
                      onChanged: (c) {
                        isSearch = true;
                        setState(() {
                          searchList = disease.where((u) => (u.name!.toLowerCase().contains(c.toLowerCase()) || u.name!.toLowerCase().contains(c.toLowerCase()))).toList();
                        });
                      },
                      onFieldSubmitted: (v) {
                        loadDisease();
                        isSearch = false;
                      },
                    ).paddingAll(8),
                    AnimatedListView(
                      shrinkWrap: true,
                      itemCount: isSearch == true ? searchList.length : snap.data!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        DiseaseModel diseaseData = isSearch == true ? searchList[i] : snap.data![i];
                        return Container(
                          width: context.width(),
                          decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.cardColor),
                          padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                          margin: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(diseaseData.name.validate(), style: primaryTextStyle()).expand(),
                              InkWell(
                                onTap: () {
                                  diseaseCont.text = diseaseData.name.toString();
                                  addDiseaseWidget(isUpdate: true, id: diseaseData.id.validate());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(defaultRadius),backgroundColor: primaryColor.withOpacity(0.2)),
                                  child: Icon(Icons.edit, color: primaryColor,size: 20),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showConfirmDialogCustom(context, title: 'Are you sure want to delete Disease?', onAccept: (v) {
                                    diseaseService.deleteDisease(id: diseaseData.id).then((value) {
                                      setState(() {});
                                      toast('Delete Successfully');
                                    });
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  margin: EdgeInsets.only(left: 8,right: 8),
                                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(defaultRadius),backgroundColor: Colors.red.withOpacity(0.2)),
                                  child: Icon(Icons.delete, color: Colors.red,size: 20),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).expand(),
                  ],
                );
              }
              if (snap.data == null && snap.data!.isEmpty) noDataWidget();
            }
            return snapWidgetHelper(snap, loadingWidget: Loader());
          },
        ),
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
    );
  }
}
