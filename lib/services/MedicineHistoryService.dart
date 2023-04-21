import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Medicine_Model.dart';
import 'package:dsr_admin/services/BaseServices.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../model/MedicineHistoryModel.dart';

class MedicineHistoryService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  MedicineHistoryService() {
    ref = fireStore.collection(MEDICINE_HISTORY);
  }

  Future<List<MedicineHistoryModel>> getAllMedicineHistory(String? id) async {
    return ref!.where('medicine_id', isEqualTo: id).get().then((value) {
      return value.docs.map((y) {
        return MedicineHistoryModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    }).catchError((e) {
      toast("error" + e.toString());
    });
  }

  Future<MedicineHistoryModel> getAllMedicineId({required String? id}) async {
    MedicineHistoryModel? data;
    await ref!.doc(id).get().then((value) {
      data =
          MedicineHistoryModel.fromJson(value.data() as Map<String, dynamic>);
    });
    return data!;
  }

  Future<void> addMedicine(String? id, MedicineHistoryModel? data) async {
    return ref!.add(data!.toJson()).then((value) {
      appStore.setLoading(false);
      ref!.doc(value.id).update({'id': value.id});
      toast('Add Medicine Successfully');
    });
  }

  Future<void> updateMedicine({String? id, MedicineHistoryModel? data}) async {
    log(data!.medicineId);
    return ref!.doc(data.medicineId).update(data.toJson()).then((value) {
      appStore.setLoading(false);
      toast('Updated Successfully');
    });
  }

  Future<void> deleteMedicine({String? id, MedicineHistoryModel? data}) async {
    ref!.doc(data!.medicineId).delete().then((value) {
      toast('Medicine Delete Successfully');
    }).catchError((e) {
      log(e);
    });
  }

  Future<void> deleteMedicineByMedicineIdList(List<String> list) async {
    var batch = FirebaseFirestore.instance.batch();
    if(list.isNotEmpty){
      await ref!.where("medicine_id", whereIn: list).get().then((value) {
        value.docs.forEach((element) {
          batch.delete(ref!.doc(element.id));
        });
      });
      await batch.commit();
    }
  }
}
