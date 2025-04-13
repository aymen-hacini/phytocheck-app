import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:bio/views/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: AppSize.appheight * .12,
              left: AppSize.appwidth * .4,
              child: SvgPicture.asset(AppImages.logo)),
          Positioned(
              top: AppSize.appheight * .04,
              child: Image.asset(
                AppImages.bg,
                fit: BoxFit.cover,
                width: AppSize.appwidth,
              )),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: AppSize.appwidth * .08,
                right: AppSize.appwidth * .08,
                bottom: AppSize.appheight * .01,
              ),
              height: AppSize.appheight * .5,
              width: AppSize.appwidth,
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 33,
                          height: 1.1,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(text: "Découvrez l'harmonie parfaite entre "),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GradientText(
                            text: 'nature',
                            style: TextStyle(
                                height: 1.1,
                                fontSize: 33,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.bold),
                            gradient: Appcolors.primaryGradient,
                          ),
                        ),
                        TextSpan(text: ' et '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GradientText(
                            text: 'medicine',
                            style: TextStyle(
                                height: 1.1,
                                fontSize: 33,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.bold),
                            gradient: Appcolors.primaryGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      children: [
                        TextSpan(text: 'Laissez notre '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GradientText(
                            text: 'IA',
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w400),
                            gradient: Appcolors.primaryGradient,
                          ),
                        ),
                        TextSpan(
                            text:
                                "  vous guider pour savoir s'ils se mélangent en toute sécurité."),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .03,
                  ),
                  GradientBtn(
                    gradient: Appcolors.primaryGradient,
                    text: "Se connecter",
                    onpress: () => Get.toNamed(AppRoutesNames.login),
                  ),
                  SizedBox(
                    height: AppSize.appheight * .02,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        children: [
                          const TextSpan(
                            text: "Vous n'avez pas de compte ? ",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                                onTap: () => Get.toNamed(AppRoutesNames.signup),
                                child: const Text(
                                  "Créer un compte ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Appcolors.primaryColor,
                                      decorationThickness: 2,
                                      fontSize: 14,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      color: Appcolors.primaryColor),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
