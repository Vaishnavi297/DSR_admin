import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Disease_Model.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';

import '../utils/Constant.dart';
import 'BaseServices.dart';

class PrescriptionService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  PrescriptionService() {
    ref = fireStore.collection(PRESCRIPTION);
  }

  Future<DocumentReference> addDisease(DiseaseModel data, {String? userId}) async {
    var doc = await ref!.add(data.toJson());
    doc.update({'id': doc.id});
    return doc;
  }

  Future<List<PrescriptionModel>> getAllPrescription() async {
    return ref!.get().then((value) {
      return value.docs.map((y) {
        return PrescriptionModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateDisease({String? id, DiseaseModel? data}) async {
    ref!.doc(id).update(data!.toJson()).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> deleteDisease({String? id, String? url}) async {
    ref!.doc(id).delete().catchError((e) {
      log(e.toString());
    });
  }
}
