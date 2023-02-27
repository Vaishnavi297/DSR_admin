class MedicineModel {
  String? id;
  String? name;
  List<MedicineTimingModel>? timing;
  num? eatingStatus;
  String? createdAt;
  String? updatedAt;

  MedicineModel({this.id, this.name, this.timing, this.eatingStatus, this.createdAt, this.updatedAt});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    eatingStatus = json['eating_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['timing'] != null) {
      timing = <MedicineTimingModel>[];
      json['timing'].forEach((v) {
        timing!.add(new MedicineTimingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['eating_status'] = this.eatingStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.timing != null) {
      data['timing'] = this.timing!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MedicineTiming {
  num? value;
  String? name;
  bool? isSelected;

  MedicineTiming({this.name, this.isSelected,this.value});
}

class MedicineTimingModel {
  num? value;
  num? status;

  MedicineTimingModel({this.value, this.status});

  MedicineTimingModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['status'] = this.status;

    return data;
  }
}
