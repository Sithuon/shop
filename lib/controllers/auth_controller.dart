import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxBool _isFirstTime = true.obs; // Default to true
  final RxBool _isLoggedIn = false.obs; // Default to false

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadAuthStatus();
  }

  void _loadAuthStatus() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  void setFirstTime(bool value) {
    _isFirstTime.value = value;
    _storage.write('isFirstTime', value);
  }

  void login(bool value) {
    _isLoggedIn.value = value;
    _storage.write('isLoggedIn', value);
  }

  void logout() {
    _isLoggedIn.value = false;
    _storage.write('isLoggedIn', false);
  }
}
