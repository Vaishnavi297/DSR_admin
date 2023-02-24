import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:dsr_admin/services/BaseServices.dart';
import 'package:dsr_admin/utils/Constant.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  PatientService() {
    ref = fireStore.collection(PATIENTS);
  }

  Future<List<PatientModel>> getAllPatient() async {
    return ref!.get().then((value) {
      return value.docs.map((y) {
        return PatientModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<int> getAllPatientLength() async {
    List<PatientModel> patientModel = [];
    return ref!.get().then((value) {
      value.docs.map((y) {
        patientModel.add(PatientModel.fromJson(y.data() as Map<String, dynamic>));
      }).toList();
      log("message " + patientModel.length.toString());

      return patientModel.length;
    });
  }

  Future<String> patientByUid({required String? id}) async {
    String name = "";
    await ref!.doc(id).get().then((value) {
      PatientModel data = PatientModel.fromJson(value.data() as Map<String, dynamic>);
      name = data.fullName.validate();
    });
    return name;
  }

  Future<void> updatePatient({String? id, PatientModel? data}) async {
    ref!.doc(id).update(data!.toJson()).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> deletePatient({String? id, String? url}) async {
    ref!.doc(id).delete().catchError((e) {
      log(e.toString());
    });
  }
}
