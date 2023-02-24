import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Disease_Model.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/Constant.dart';
import 'BaseServices.dart';

class PrescriptionService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  PrescriptionService() {
    ref = fireStore.collection(PRESCRIPTION);
  }

  Future<List<PrescriptionModel>> getAllPrescription() async {
    return ref!.get().then((value) {
      return value.docs.map((y) {
        return PrescriptionModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<int> getAllPrescriptionLength() async {
    int? length = 0;
    return ref!.doc().get().then((value) {
      log("message" + value.data().toString());
      return length;
    });
  }

  Future<List<PrescriptionModel>> getPrescriptionByUser(String? id) async {
    return ref!.where('user_id', isEqualTo: id).get().then((value) {
      return value.docs.map((y) {
        return PrescriptionModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  getPrescription(String? id, MedicineModel? data) async {
    return ref!.doc(id).collection(MEDICINE).add(data!.toJson()).then((value) {
      appStore.setLoading(false);
      toast('Add Medicine Successfully');
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
