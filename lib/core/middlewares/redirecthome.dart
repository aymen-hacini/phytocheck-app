import 'package:bio/core/constants/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in -> go to Home
      return const RouteSettings(name: AppRoutesNames.homepage);
    } else {
      // Not logged in -> go to Onboarding
      return const RouteSettings(name: AppRoutesNames.onboarding);
    }
  }
}
