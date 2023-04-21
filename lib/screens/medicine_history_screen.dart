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

class _MedicineHistoryScreenState extends State<MedicineHistoryScreen>
    with TickerProviderStateMixin {
  Future<List<MedicineHistoryModel>>? future;
  final ScrollController scrollController = ScrollController();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    init();
  }

  void init() async {
    future = medicineHistoryService
        .getAllMedicineHistory(widget.medicineModel!.id.validate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.medicineModel!.name.validate(),
          color: primaryColor, textColor: white),
      body: FutureBuilder<List<MedicineHistoryModel>>(
        future: future,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data != null && snap.data!.isNotEmpty) {
              var medicineHistoryList = snap.data ?? [];

              return SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                child: DefaultTabController(
                  length: 4,
                  child: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              medicineHistoryList.isNotEmpty
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.all(10),
                                      child: getBody(medicineHistoryList),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ];
                    },
                    body: getTabView(medicineHistoryList),
                  ),
                ),
              );
            } else {
              return noDataWidget();
            }
          }
          return snapWidgetHelper(snap, loadingWidget: Loader());
        },
      ),
    );
  }

  Widget getBody(List<MedicineHistoryModel> list) {
    var totalMedicineCount = list.length;
    var totalMissedMedicineCount =
        list.where((element) => element.isMissed ?? false).toList().length;
    var totalMedicineTakenOnTimeCount =
        list.where((element) => (element.takenOnTime ?? false)).toList().length;
    var totalMedicineNotTakenOnTimeCount = list
        .where((element) => !(element.takenOnTime ?? false))
        .toList()
        .length;

    var missedPercentage = totalMedicineCount != 0
        ? ((totalMissedMedicineCount / totalMedicineCount) * 100)
        : 0;
    var takenOnTimePercentage = totalMedicineCount != 0
        ? ((totalMedicineTakenOnTimeCount / totalMedicineCount) * 100)
        : 0;
    var notTakenOnTimePercentage = totalMedicineCount != 0
        ? ((totalMedicineNotTakenOnTimeCount / totalMedicineCount) * 100)
        : 0;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: getDataView(list, "Medicine not Taken",
                  "${missedPercentage.toStringAsFixed(1)} %"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: getDataView(list, "Taken On Time",
                  "${takenOnTimePercentage.toStringAsFixed(1)} %"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: getDataView(list, "Not Taken On Time",
                  "${notTakenOnTimePercentage.toStringAsFixed(1)} %"),
            ),
          ),
        ],
      ),
    );
  }

  void onCardClick(List<MedicineHistoryModel> list, String title) {
    var totalMissedMedicineList =
        list.where((element) => element.isMissed ?? false).toList();
    var totalMedicineTakenOnTimeList =
        list.where((element) => element.takenOnTime ?? false).toList();
    var totalMedicineNotTakenOnTimeList =
        list.where((element) => !(element.takenOnTime ?? false)).toList();

    var selectedList = [];

    if (title == "Medicine not Taken") {
      selectedList = totalMissedMedicineList;
    } else if (title == "Not Taken On Time") {
      selectedList = totalMedicineNotTakenOnTimeList;
    } else {
      selectedList = totalMedicineTakenOnTimeList;
    }

    print(selectedList.length);
    print(selectedList
        .where((element) => element.timingStatus == 1)
        .toList()
        .length);

    var morningPercentage = (selectedList.isNotEmpty)
        ? ((selectedList
                    .where((element) => element.timingStatus == 1)
                    .toList()
                    .length /
                (selectedList.length)) *
            100)
        : 0;
    var afternoonPercentage = (selectedList.isNotEmpty)
        ? ((selectedList
                    .where((element) => element.timingStatus == 2)
                    .toList()
                    .length /
                (selectedList.length)) *
            100)
        : 0;
    var evePercentage = (selectedList.isNotEmpty)
        ? ((selectedList
                    .where((element) => element.timingStatus == 3)
                    .toList()
                    .length /
                (selectedList.length)) *
            100)
        : 0;
    var nightPercentage = (selectedList.isNotEmpty)
        ? ((selectedList
                    .where((element) => element.timingStatus == 4)
                    .toList()
                    .length /
                (selectedList.length)) *
            100)
        : 0;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: primaryTextStyle(
                size: 16,
                weight: FontWeight.w700,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: getPercentageDataView(
                        "Morning",
                        "${morningPercentage.toStringAsFixed(1)} %",
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Center(
                      child: getPercentageDataView(
                        "Afternoon",
                        "${afternoonPercentage.toStringAsFixed(1)} %",
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: getPercentageDataView(
                        "Evening",
                        "${evePercentage.toStringAsFixed(1)} %",
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Center(
                      child: getPercentageDataView(
                        "Night",
                        "${nightPercentage.toStringAsFixed(1)} %",
                      ),
                    )),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget getDataView(
      List<MedicineHistoryModel> list, String title, String value) {
    return InkWell(
      onTap: () {
        onCardClick(list, title);
      },
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: boldTextStyle(size: 14, weight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  style: boldTextStyle(
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPercentageDataView(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: boldTextStyle(size: 14, weight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: boldTextStyle(
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTabView(List<MedicineHistoryModel> list) {
    var morningMedicineHistoryList = list
        .where((element) =>
            element.timingStatus != null && element.timingStatus == 1)
        .toList();
    var afternoonMedicineHistoryList = list
        .where((element) =>
            element.timingStatus != null && element.timingStatus == 2)
        .toList();
    var eveningMedicineHistoryList = list
        .where((element) =>
            element.timingStatus != null && element.timingStatus == 3)
        .toList();
    var nightMedicineHistoryList = list
        .where((element) =>
            element.timingStatus != null && element.timingStatus == 4)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: context.cardColor,
          child: TabBar(
            controller: tabController,
            indicatorColor: primaryColor,
            labelStyle: boldTextStyle(color: Colors.white),
            unselectedLabelStyle: boldTextStyle(color: Colors.grey),
            tabs: [
              Tab(text: 'Morning'),
              Tab(text: 'Afternoon'),
              Tab(text: 'Evening'),
              Tab(text: 'Night'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              getMedicineHistoryList(morningMedicineHistoryList),
              getMedicineHistoryList(afternoonMedicineHistoryList),
              getMedicineHistoryList(eveningMedicineHistoryList),
              getMedicineHistoryList(nightMedicineHistoryList),
            ],
          ),
        ),
      ],
    );
  }

  Widget getMedicineHistoryList(List<MedicineHistoryModel> list) {
    return AnimatedListView(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return Container(
          padding: EdgeInsets.all(8),
          width: context.width(),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(list[i].date.validate(),
                  style: primaryTextStyle(
                    weight: FontWeight.w600,
                  )),
              Text(
                  (list[i].isMissed ?? false)
                      ? "Missed"
                      : (list[i].takenOnTime ?? false)
                          ? "On Time"
                          : "Not Taken On Time",
                  style: secondaryTextStyle(
                    color: (list[i].isMissed ?? false)
                        ? Colors.red
                        : (list[i].takenOnTime ?? false)
                            ? Colors.green
                            : primaryColor,
                  )),
            ],
          ),
        );
      },
    );
  }
}
