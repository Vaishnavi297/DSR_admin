import 'package:dsr_admin/model/Disease_Model.dart';

class PrescriptionModel {
  DiseaseModel? diseaseData;
  List<Prescription>? prescriptionList;

  PrescriptionModel(this.diseaseData, this.prescriptionList);

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    diseaseData = json['disease_data'] != null ? DiseaseModel.fromJson(json['disease_data']) : null;
    prescriptionList = json['prescription_data_list'] != null ? (json['prescription_data_list'] as List).map((i) => Prescription.fromJson(i)).toList() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.diseaseData != null) {
      data['disease_data'] = this.diseaseData!.toJson();
    }

    if (this.prescriptionList != null) {
      data['prescription_data_list'] = this.prescriptionList!.map((v) => v.toJson()).toList();
    }

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
