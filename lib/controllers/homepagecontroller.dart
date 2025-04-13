import 'dart:convert';

import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class Homepagecontroller extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentpage = 0;
  var isLoading = false.obs;
  var isobscure = true.obs;
  var isProfessional = false.obs;
  var userModel = Rxn<UserModel>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<String> selectedMedicine = "".obs;
  final picker = ImagePicker();

  late TextEditingController emailcontrollerSignin;
  late TextEditingController passwordcontrollerSignin;

  late TextEditingController emailcontrollerSignup;
  late TextEditingController passwordcontrollerSignup;
  late TextEditingController confirmpasswordcontrollerSignup;

  late TextEditingController emailcontrollerForgetpass;

  late TextEditingController declarationPlant;
  late TextEditingController declarationPlantDescription;
  late TextEditingController declarationCasDescription;

  late TextEditingController feedbackText;

  changePage(int currentindex) {
    currentpage = currentindex;
    update();
  }

  toggleObscure() {
    isobscure.value = !isobscure.value;
  }

  selectMedicine(String medicine) {
    selectedMedicine.value = medicine;
  }

  changeProfessional(bool status) {
    isProfessional.value = status;
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isLoading.value = true;

      // Convert image to Base64
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);

      // Upload to Firestore
      await uploadProfileImage(base64Image);

      isLoading.value = false;
    }
  }

  Future<void> uploadProfileImage(String base64Image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update user profile in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImageUrl': base64Image, // Save Base64 string in Firestore
        });

        // Update local user model in GetX
        userModel.value =
            userModel.value?.copyWith(profileImageUrl: base64Image);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload profile image: $e");
    }
  }

  Future<void> signInWithEmail() async {
    isLoading.value = true;

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontrollerSignin.text.trim(),
              password: passwordcontrollerSignin.text.trim());

      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        fetchUserProfile();
        Get.offAllNamed(AppRoutesNames.homepage);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password provided.");
      } else {
        Get.snackbar("Error", e.message ?? "Unknown error.");
      }
    } catch (e) {
      Get.snackbar("Error", "Unexpected error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar("Canceled", "Google sign-in canceled");
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final userExists = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        userExists.exists
            ? null
            : await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .update({
                'email': firebaseUser.email,
                'profileImageUrl': firebaseUser
                    .photoURL, // Default value for profile image (empty or default image URL)
                'createdAt': FieldValue
                    .serverTimestamp(), // Timestamp when account was created
              });
        fetchUserProfile();

        Get.offAllNamed(AppRoutesNames.homepage);
      }
    } catch (e) {
      Get.snackbar("Sign-In Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Function to fetch the user's profile image URL
  Future<void> fetchUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user document from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final profileImageUrl = userDoc.data()?['profileImageUrl'] ??
              ''; // Get profile image URL or default to empty

          // Update the userModel with the fetched data
          userModel.value = UserModel(
            uid: user.uid,
            email: user.email!,
            displayName: user.displayName,
            photoUrl: profileImageUrl,
          );
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch profile image: $e");
    } finally {
      isLoading.value = false; // Update loading state
    }
  }

  Future<void> createAccountWithEmail() async {
    isLoading.value = true;
    if (passwordcontrollerSignup.text.trim() ==
        confirmpasswordcontrollerSignup.text.trim()) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontrollerSignup.text.trim(),
                password: passwordcontrollerSignup.text.trim());

        final firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          // Create a Firestore document for the user
          await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .update({
            'email': firebaseUser.email,
            'profileImageUrl':
                '', // Default value for profile image (empty or default image URL)
            'createdAt': FieldValue
                .serverTimestamp(), // Timestamp when account was created
          });
          // You can update displayName or photoURL if needed
          userModel.value = UserModel.fromFirebaseUser(firebaseUser);
          print("Account created for: ${firebaseUser.email}");
          Get.offAllNamed(
              AppRoutesNames.homepage); // Redirect to home after signup
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar("Signup Error", "That email is already in use.");
        } else if (e.code == 'weak-password') {
          Get.snackbar("Signup Error", "Password is too weak.");
        } else {
          Get.snackbar("Signup Error", e.message ?? "Unknown error.");
        }
      } catch (e) {
        Get.snackbar("Signup Failed", e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;

      Get.snackbar("Signup Error", "Passwords don't match");
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      Get.offAllNamed(AppRoutesNames.onboarding);

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Also sign out from Google if signed in
      await GoogleSignIn().signOut();

      // Clear user model
      userModel.value = null;

      emailcontrollerSignin.clear();
      emailcontrollerSignup.clear();
      passwordcontrollerSignup.clear();
      passwordcontrollerSignin.clear();
      confirmpasswordcontrollerSignup.clear();
      emailcontrollerForgetpass.clear();
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendPasswordReset() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontrollerForgetpass.text.trim());
      Get.snackbar(
          "Reset Email Sent", "Check your inbox to reset your password");
      Get.toNamed(AppRoutesNames.resetpass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found with that email.");
      } else {
        Get.snackbar("Error", e.message ?? "Something went wrong.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDeclaration(Map<String, dynamic> declaration) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar("Error", "No user is currently logged in");
      return;
    }

    try {
      isLoading(true);
      await _firestore.collection("users").doc(user.uid).update({
        "declarations": FieldValue.arrayUnion([declaration])
      });
      Get.snackbar("Success", "Declaration added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add declaration: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addFeedback(Map<String, dynamic> feedbackText) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar("Error", "No user is currently logged in");
      return;
    }

    try {
      isLoading(true);
      await _firestore.collection("users").doc(user.uid).update({
        "feedbacks": FieldValue.arrayUnion([feedbackText])
      });
      Get.snackbar("Success", "Feedback added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add Feedback: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getUserType() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar("Error", "No user is currently logged in");
      return;
    }

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (docSnapshot.exists) {
        String? type = docSnapshot.data()?['Type'];
        if (type != null) {
          // You can store it in a variable or state
          type == "Professionnel de la santé"
              ? isProfessional(true)
              : isProfessional(false);
        }
      }
    } catch (e) {
      print("Error fetching user type: $e");
    }
  }

  @override
  void onInit() async {
    fetchUserProfile();
    emailcontrollerSignin = TextEditingController();
    emailcontrollerSignup = TextEditingController();
    passwordcontrollerSignin = TextEditingController();
    passwordcontrollerSignup = TextEditingController();
    confirmpasswordcontrollerSignup = TextEditingController();
    emailcontrollerForgetpass = TextEditingController();

    declarationPlant = TextEditingController();
    declarationPlantDescription = TextEditingController();
    declarationCasDescription = TextEditingController();

    feedbackText = TextEditingController();

    await getUserType();

    super.onInit();
  }
}
