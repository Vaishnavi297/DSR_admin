import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/main.dart';
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
    List<PrescriptionModel> prescriptionList = [];
    return ref!.get().then((value) {
      value.docs.map((y) {
        prescriptionList
            .add(PrescriptionModel.fromJson(y.data() as Map<String, dynamic>));
      }).toList();

      return prescriptionList.length;
    });
  }

  Future<List<PrescriptionModel>> getPrescriptionByUser(String? id) async {
    return ref!.where('user_id', isEqualTo: id).get().then((value) {
      return value.docs.map((y) {
        return PrescriptionModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updatePrescription({String? id, PrescriptionModel? data}) async {
    log(data!.id);
    return ref!.doc(id).update(data.toJson()).then((value) {
      appStore.setLoading(false);
      toast('Updated Successfully');
    });
  }

  Future<void> updatePrescriptionStatus({String? id, String? status}) async {
    return ref!.doc(id).get().then((value) {
      appStore.setLoading(false);
      ref!.doc(value.id).update({'status': status});
      toast('Updated Successfully');
    });
  }

  Future<void> deletePrescription({String? id, String? url}) async {
    ref!.doc(id).delete().catchError((e) {
      log(e.toString());
    });
  }

  Future<void> deletePrescriptionByUser(String userId) async {
    var batch = FirebaseFirestore.instance.batch();
    await ref!.where("user_id", isEqualTo: userId).get().then((value) {
      value.docs.forEach((element) {
        batch.delete(ref!.doc(element.id));
      });
    });
    await batch.commit();
  }
}
