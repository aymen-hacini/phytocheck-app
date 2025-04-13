import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/core/middlewares/redirecthome.dart';
import 'package:bio/views/screens/auth/forgetpass.dart';
import 'package:bio/views/screens/auth/login.dart';
import 'package:bio/views/screens/auth/resetpass.dart';
import 'package:bio/views/screens/auth/signup.dart';
import 'package:bio/views/screens/details/plant_details.dart';
import 'package:bio/views/screens/express/express_button.dart';
import 'package:bio/views/screens/homepage/homepage.dart';
import 'package:bio/views/screens/onboarding/onboarding.dart';
import 'package:bio/views/screens/profile/my_profile.dart';
import 'package:bio/views/screens/search/searchplants.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(
      name: "/",
      page: () => const Onboarding(),
      transition: Transition.fadeIn,
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: AppRoutesNames.onboarding,
      page: () => const Onboarding(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.login,
      page: () => const Login(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.signup,
      page: () => const Signup(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.forgetpass,
      page: () => const Forgetpass(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.resetpass,
      page: () => const Resetpass(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.homepage,
      page: () => const Homepage(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.plantDetails,
      page: () => const PlantDetails(),
      transition: Transition.fadeIn),
  GetPage(
      name: AppRoutesNames.myprofile,
      page: () => const MyProfile(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: AppRoutesNames.searchScreen,
      page: () => const Searchplants(),
      transition: Transition.zoom),
  GetPage(
      name: AppRoutesNames.expressButton,
      page: () => const ExpressButton(),
      transition: Transition.downToUp),
];
