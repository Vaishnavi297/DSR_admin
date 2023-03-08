import 'package:dsr_admin/model/Disease_Model.dart';

class PrescriptionModel {
  DiseaseModel? diseaseData;
  String? id;
  String? status;
  String? path;
  String? url;
  String? uid;
  String? reason;
  String? createdAt;
  String? updatedAt;

  PrescriptionModel({this.diseaseData, this.id, this.status, this.path, this.url, this.uid, this.createdAt, this.updatedAt});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    diseaseData = json['disease_data'] != null ? DiseaseModel.fromJson(json['disease_data']) : null;
    id = json['id'];
    status = json['status'];
    path = json['path'];
    url = json['url'];
    uid = json['user_id'];
    createdAt = json['create_date'];
    updatedAt = json['update_date'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.diseaseData != null) {
      data['disease_data'] = this.diseaseData!.toJson();
    }
    data['id'] = this.id;
    data['status'] = this.status;
    data['path'] = this.path;
    data['url'] = this.url;
    data['user_id'] = this.uid;
    data['create_date'] = this.createdAt;
    data['update_date'] = this.updatedAt;
    data['reason'] = this.reason;
    return data;
  }
}

class Prescription {
  String? id;
  String? status;
  String? url;

  Prescription(this.id, this.status, this.url);

  Prescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['url'] = this.url;
    return data;
  }
}
