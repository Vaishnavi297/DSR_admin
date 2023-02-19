import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/Common.dart';
import '../utils/Constant.dart';

part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @observable
  String uid = '';

  @observable
  String email = '';

  @observable
  String name = '';

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  Future<void> setLogin(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setUID(String val, {bool isInitializing = false}) async {
    uid = val;
    if (!isInitializing) await setValue(UID, val);
  }

  @action
  Future<void> setName(String val, {bool isInitializing = false}) async {
    name = val;
    if (!isInitializing) await setValue(NAME, val);
  }
  @action
  Future<void> setEmail(String val, {bool isInitializing = false}) async {
    email = val;
    if (!isInitializing) await setValue(USER_EMAIL, val);
  }
}
