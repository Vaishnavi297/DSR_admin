class MedicineHistoryModel {
  String? date;
  bool? isMissed;
  String? medicineId;
  bool? takenOnTime;
  int? timingStatus;

  MedicineHistoryModel({
    this.date,
    this.isMissed,
    this.medicineId,
    this.takenOnTime,
    this.timingStatus,
  });

  MedicineHistoryModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isMissed = json['is_missed'];
    medicineId = json['medicine_id'];
    takenOnTime = json['taken_on_time'];
    timingStatus = json['timing_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['is_missed'] = this.isMissed;
    data['medicine_id'] = this.medicineId;
    data['taken_on_time'] = this.takenOnTime;
    data['timing_status'] = this.timingStatus;

    return data;
  }
}
