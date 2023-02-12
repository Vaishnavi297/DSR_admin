import 'package:mobx/mobx.dart';

import '../utils/Common.dart';
import '../utils/Constant.dart';

part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  Future<void> setLogin(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }
}
