import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/services/BaseServices.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class MedicineService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  MedicineService() {
    ref = fireStore.collection(PRESCRIPTION);
  }

  Future<List<MedicineModel>> getAllMedicine(String? id) async {
    return ref!.doc(id).collection(MEDICINE).get().then((value) {
      return value.docs.map((y) {
        return MedicineModel.fromJson(y.data());
      }).toList();
    });
  }

  Future<MedicineModel> getAllMedicineId({required String? id}) async {
    MedicineModel? data;
    await ref!.doc(id).get().then((value) {
      data = MedicineModel.fromJson(value.data() as Map<String, dynamic>);
    });
    return data!;
  }

  Future<void> addPrescription(String? id, MedicineModel? data) async {
    return ref!.doc(id).collection(MEDICINE).add(data!.toJson()).then((value) {
      appStore.setLoading(false);
      log("----" + value.id);
      ref!.doc(id).collection(MEDICINE).doc(value.id).update({'id': value.id});
      toast('Add Medicine Successfully');
    });
  }

  Future<void> updateMedicine(String? id, MedicineModel? data) async {
    return ref!.doc(id).collection(MEDICINE).doc(data!.id).update(data.toJson()).then((value) {
      appStore.setLoading(false);
      toast('Updated Successfully');
    });
  }

  Future<void> deleteMedicine({String? id, MedicineModel? data}) async {
    ref!.doc(id).collection(MEDICINE).doc(data!.id).delete().then((value) {
      toast('Medicine Delete Successfully');
    }).catchError((e) {
      log(e);
    });
  }
}
