import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/models/usermodel.dart';
import 'package:bio/views/screens/homepage/homepage.dart';
import 'package:bio/views/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => const Onboarding());
      } else {
        Get.find<Homepagecontroller>().userModel.value =
            UserModel.fromFirebaseUser(user);
        Get.offAll(() => const Homepage());
      }
    });
  }
}
