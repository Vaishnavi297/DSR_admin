import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/UserModel.dart';
import '../utils/Constant.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Future<void> signUpWithEmailPassword(context, {required String email, required String password,String? phoneNumber, UserModel? userData}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    log('=====User Data ${userCredential.user}=======');

    if (userCredential.user != null) {
      User currentUser = userCredential.user!;

      UserModel userModel = UserModel();

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
        await signInWithEmailPassword(context, email: email, password: password).then((value) {
          toast('Login SuccessFully');
        });
      });
    } else {
      throw 'Some thing wants wrong';
    }
  }

  //
  Future<void> signInWithEmailPassword(context, {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      final User user = value.user!;
      UserModel userModel = await userService.getUser(email: user.email);

      //Login Details to SharedPreferences
      setValue(UID, userModel.id);
      setValue(USER_EMAIL, userModel.email);
      setValue(IS_LOGGED_IN, true);
    }).catchError((error) async {});
  }
}
