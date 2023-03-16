import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/services/BaseServices.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';

class MedicineService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  MedicineService() {
    ref = fireStore.collection(MEDICINE);
  }

  Future<List<MedicineModel>> getAllMedicine(String? id) async {
    return ref!.where('prescriptionId',isEqualTo: id).get().then((value) {
      return value.docs.map((y) {
        return MedicineModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    }).catchError((e) {
      toast("error"+e.toString());
    });
  }

  Future<MedicineModel> getAllMedicineId({required String? id}) async {
    MedicineModel? data;
    await ref!.doc(id).get().then((value) {
      data = MedicineModel.fromJson(value.data() as Map<String, dynamic>);
    });
    return data!;
  }

  Future<void> addMedicine(String? id, MedicineModel? data) async {
    return ref!.add(data!.toJson()).then((value) {
      appStore.setLoading(false);
      ref!.doc(value.id).update({'id': value.id});
      toast('Add Medicine Successfully');
    });
  }

  Future<void> updateMedicine({String? id, MedicineModel? data}) async {
    log(data!.id);
    return ref!.doc(data.id).update(data.toJson()).then((value) {
      appStore.setLoading(false);
      toast('Updated Successfully');
    });
  }

  Future<void> deleteMedicine({String? id, MedicineModel? data}) async {
    ref!.doc(data!.id).delete().then((value) {
      toast('Medicine Delete Successfully');
    }).catchError((e) {
      log(e);
    });
  }
}
