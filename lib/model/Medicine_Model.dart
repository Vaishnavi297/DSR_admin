class MedicineModel {
  String? id;
  String? name;
  List<String>? timing;
  bool? eatingStatus;
  bool? status;
  String? createdAt;
  String? updatedAt;

  MedicineModel({this.id, this.name, this.timing, this.eatingStatus, this.status, this.createdAt, this.updatedAt});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    eatingStatus = json['eating_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    timing = json['timing'] != null ? List<String>.from(json['timing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['eating_status'] = this.eatingStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.timing != null) {
      data['timing'] = this.timing;
    }

    return data;
  }
}

class MedicineTiming {
  String? name;
  bool? isSelected;

  MedicineTiming({this.name, this.isSelected});
}
