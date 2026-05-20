import 'package:get/get.dart';
import '../services/session_service.dart';
import '../screen/login_screen.dart';
import '../screen/main_screen.dart';

class AuthController extends GetxController {
  final SessionService _sessionService = SessionService();
  var isLoading = true.obs;
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final user = await _sessionService.getSession();
    if (user != null) {
      username.value = user;
      Get.offAll(() => const MainScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
    isLoading.value = false;
  }

  Future<void> login(String user) async {
    isLoading.value = true;
    await _sessionService.saveSession(user);
    username.value = user;
    Get.offAll(() => const MainScreen());
    isLoading.value = false;
  }

  Future<void> logout() async {
    await _sessionService.clearSession();
    username.value = '';
    Get.offAll(() => const LoginScreen());
  }
}
