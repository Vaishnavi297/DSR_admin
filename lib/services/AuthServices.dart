import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../model/Patient_Model.dart';
import '../utils/Constant.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Future<void> signUpWithEmailPassword(context, {required String email, required String password, String? phoneNumber, PatientModel? userData}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e) {
      toast(e.toString(), print: true);

     return e;
    });
    log('=====User Data ${userCredential.user}=======');

    if (userCredential.user != null) {
      User currentUser = userCredential.user!;
      PatientModel userModel = PatientModel();

      /// Create user
      userModel.id = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.password = userData!.password;
      userModel.fullName = userData.fullName;
      userModel.mobileNumber = userData.mobileNumber;
      userModel.createdAt = Timestamp.now().toDate().toString();
      userModel.updatedAt = Timestamp.now().toDate().toString();

      log('=====User Data ${userModel.toJson()} =======');

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        log("value----" + value.toString());
        appStore.setLoading(false);
        await signInWithEmail(email, password).then((value) {
          toast('Login SuccessFully');
        });
      });
    } else {
      throw 'Some thing wants wrong';
    }
  }

  Future<PatientModel> signInWithEmail(String email, String password) async {
    if (await userService.isUserExist(email)) {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        PatientModel userModel = PatientModel();
        User user = userCredential.user!;

        return await userService.userByEmail(user.email).then((value) async {
          userModel = value;
          log(userModel.toJson().toString());
          await setValue(PASSWORD, password);
          appStore.setUID(userModel.id.validate());
          appStore.setEmail(userModel.email.validate());
          appStore.setName(userModel.fullName.validate());
          appStore.setLogin(true);

          return userModel;
        }).catchError((e) {
          log("log " + e.toString());
          throw e;
        });
      } else {
        throw errorSomethingWentWrong;
      }
    } else {
      throw 'You are not registered with us';
    }
  }
}
