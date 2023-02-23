class MedicineModel {
  String? id;
  String? name;
  String? timing;
  bool? eatingStatus;
  bool? status;
  String? createdAt;
  String? updatedAt;

  MedicineModel(this.id, this.name, this.timing, this.eatingStatus, this.status, this.createdAt, this.updatedAt);

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timing = json['timing'];
    eatingStatus = json['eating_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['timing'] = this.timing;
    data['eating_status'] = this.eatingStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
