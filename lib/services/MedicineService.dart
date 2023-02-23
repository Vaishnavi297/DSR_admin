import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/services/BaseServices.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  PatientService() {
    ref = fireStore.collection(MEDICINE);
  }

  Future<List<MedicineModel>> getAllMedicine() async {
    return ref!.get().then((value) {
      return value.docs.map((y) {
        return MedicineModel.fromJson(y.data() as Map<String, dynamic>);
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

  Future<void> updateMedicine({String? id, PatientModel? data}) async {
    ref!.doc(id).update(data!.toJson()).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> deleteMedicine({String? id, String? url}) async {
    ref!.doc(id).delete().catchError((e) {
      log(e.toString());
    });
  }
}
