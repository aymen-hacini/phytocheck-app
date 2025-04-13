import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Profilecontroller extends GetxController {
  var selectedRole = "".obs;

  var isloading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController healthProName;
  late TextEditingController healthProfession;
  late TextEditingController healthLieuTravail;
  late TextEditingController healthAdress;
  //==============================================
  late TextEditingController patientNom;
  late TextEditingController patientAge;
  late TextEditingController patientLieuResidence;

  selectRole(String? chosenRole) {
    selectedRole.value = chosenRole!;
  }

  Future<void> updateDocument({
    required Map<String, dynamic> additionalFields,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      isloading(true);
      await _firestore
          .collection("users")
          .doc(user!.uid)
          .update(additionalFields);
      Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update document: $e");
    } finally {
      isloading(false);
    }
  }


  @override
  void onInit() {
    healthProName = TextEditingController();
    healthProfession = TextEditingController();
    healthLieuTravail = TextEditingController();
    healthAdress = TextEditingController();
    patientNom = TextEditingController();
    patientAge = TextEditingController();
    patientLieuResidence = TextEditingController();
    super.onInit();
  }
}
