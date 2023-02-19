import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/UserModel.dart';
import '../utils/Constant.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Future<void> signUpWithEmailPassword(context, {required String email, required String password, String? phoneNumber, UserModel? userData}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e) {
      toast(e.toString(), print: true);
    });
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
        await signInWithEmail(email, password).then((value) {
          toast('Login SuccessFully');
        });
      });
    } else {
      throw 'Some thing wants wrong';
    }
  }

  Future<UserModel> signInWithEmail(String email, String password) async {
    if (await userService.isUserExist(email)) {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        UserModel userModel = UserModel();
        User user = userCredential.user!;

        return await userService.userByEmail(user.email).then((value) async {
          log('Signed in');
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
