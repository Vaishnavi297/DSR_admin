import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsr_admin/model/Patient_Model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/Constant.dart';
import 'BaseServices.dart';

class AdminService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  AdminService() {
    ref = fireStore.collection(ADMIN_COLLECTION);
  }

  //
  // Future<void> updateUserInfo(Map data, String id, {File? profileImage}) async {
  //   if (profileImage != null) {
  //     String fileName = basename(profileImage.path);
  //     Reference storageRef = _storage.ref().child("$PROFILE_IMAGE/$fileName");
  //     UploadTask uploadTask = storageRef.putFile(profileImage);
  //     await uploadTask.then((e) async {
  //       await e.ref.getDownloadURL().then((value) {
  //         //appStore.setUserProfile(value);
  //         data.putIfAbsent("photoUrl", () => value);
  //       });
  //     });
  //   }
  //
  //   return ref!.doc(id).update(data as Map<String, Object?>);
  // }

  Future<void> updateUserStatus(Map data, String id) async {
    return ref!.doc(id).update(data as Map<String, Object?>);
  }

  Future<PatientModel> getUser({String? email}) {
    return ref!.where("email", isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        return PatientModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'User Not found';
      }
    });
  }
  Future<PatientModel> getUserExit({String? email}) {
    return ref!.where("email", isEqualTo: email).get().then((value) {
      if (value.docs.length == 1) {
        return PatientModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'User is already exit';
      }
    });
  }
  Stream<List<PatientModel>> users({String? searchText}) {
    return ref!.snapshots().map((x) {
      return x.docs.map((y) {
        return PatientModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<PatientModel> userByEmail(String? email) async {
    return await ref!.where('email', isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return PatientModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'No User Found';
      }
    });
  }

  Stream<PatientModel> singleUser(String? id, {String? searchText}) {
    return ref!.where('uid', isEqualTo: id).limit(1).snapshots().map((event) {
      return PatientModel.fromJson(event.docs.first.data() as Map<String, dynamic>);
    });
  }

  Future<PatientModel> userByMobileNumber(String? phone) async {
    log("Phone $phone");
    return await ref!.where('phoneNumber', isEqualTo: phone).limit(1).get().then((value) {
      //   log(value);
      if (value.docs.isNotEmpty) {
        return PatientModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No user found";
      }
    });
  }
}
