import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/screens/patient_detail_screen.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/Common.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  TextEditingController searchCont = TextEditingController();

  FocusNode searchFocus = FocusNode();
  List<PatientModel> disease = [];
  List<PatientModel> searchList = [];

  Future<List<PatientModel>>? future;

  bool? isSearch = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = patientService.getAllPatient();
    200.milliseconds.delay.then((value) => context.requestFocus(searchFocus));
    loadDisease();
  }

  void loadDisease() {
    patientService.getAllPatient().then((value) {
      log(value);
      disease = value;
      if (searchCont.text.isNotEmpty) {
        searchList.clear();
        for (int i = 0; i <= searchCont.text.length; i++) {
          String data = disease[i].fullName.validate();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: appBarWidget('Patient', showBack: false, color: primaryColor, textColor: white),
      body: RefreshIndicator(
        onRefresh: () async {
          await 1.seconds.delay;
          init();
          setState(() {});
        },
        child: FutureBuilder<List<PatientModel>>(
          future: future,
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data != null && snap.data!.isNotEmpty) {
                return Column(
                  children: [
                    AppTextField(
                      controller: searchCont,
                      decoration: inputDecoration(context, prefixIcon: Icon(Icons.search), labelText: 'Search User'),
                      textFieldType: TextFieldType.EMAIL,
                      errorThisFieldRequired: 'This field is required',
                      autoFillHints: [AutofillHints.email],
                      onChanged: (c) {
                        isSearch = true;
                        setState(() {
                          searchList = disease.where((u) => (u.fullName!.toLowerCase().contains(c.toLowerCase()) || u.fullName!.toLowerCase().contains(c.toLowerCase()))).toList();
                        });
                      },
                      onFieldSubmitted: (v) {
                        loadDisease();
                        isSearch = false;
                      },
                    ).paddingAll(8),
                    AnimatedListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      itemCount: isSearch == true ? searchList.length : snap.data!.length,
                      itemBuilder: (context, i) {
                        PatientModel patientData = isSearch == true ? searchList[i] : snap.data![i];

                        return Container(
                          margin: EdgeInsets.all(8),
                          decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: context.scaffoldBackgroundColor),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              8.height,
                              Text(patientData.fullName.validate(), style: boldTextStyle(color: textPrimaryColorGlobal)),
                              8.height,
                              RichText(
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                text: TextSpan(
                                  text: 'Age: ',
                                  style: secondaryTextStyle(),
                                  children: <TextSpan>[
                                    TextSpan(text: patientData.age, style: boldTextStyle()),
                                  ],
                                ),
                              ),
                              8.height,
                            ],
                          ),
                        ).onTap(() {
                          PatientDetailScreen(userData: patientData).launch(context);
                        });
                      },
                    ).expand(),
                  ],
                );
              }
              if (snap.data != []) noDataWidget();
            }
            return snapWidgetHelper(snap, loadingWidget: Loader());
          },
        ),
      ),
    );
  }
}
