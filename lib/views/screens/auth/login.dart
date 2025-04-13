import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Login extends GetView<Homepagecontroller> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: AppSize.appwidth * .05,
          right: AppSize.appwidth * .05,
          top: AppSize.appheight * .08,
          bottom: AppSize.appheight * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue \nà nouveau!\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700,
                height: 1.19,
              ),
            ),
            TextFormField(
              controller: controller.emailcontrollerSignin,
              validator: (v) {
                if (!GetUtils.isEmail(v!)) {
                  return "Veuillez saisir un format d'e-mail correct";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUnfocus,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0x42676767),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Appcolors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.black,
                  ),
                  hintText: "Entrez votre adresse e-mail",
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14)),
            ),
            SizedBox(
              height: AppSize.appheight * .03,
            ),
            Obx(
              () => TextFormField(
                controller: controller.passwordcontrollerSignin,
                obscureText: controller.isobscure.value,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0x42676767),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Appcolors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 24,
                      color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => controller.toggleObscure(),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                        child: Icon(
                          controller.isobscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          key: ValueKey<bool>(controller.isobscure.value),
                          size: 24,
                        ),
                      ),
                    ),
                    hintText: "Entrez votre mot de passe",
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 14)),
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutesNames.forgetpass),
                  child: const Text(
                    'Mot de passe oublié?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Appcolors.primaryColor,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppSize.appheight * .03,
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Appcolors.primaryColor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientBtnIcon(
                            gradient: Appcolors.primaryGradient,
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: AppSize.appheight * .04,
                              color: Colors.white,
                            ),
                            onpress: () => controller.signInWithEmail())
                      ],
                    ),
            ),
            SizedBox(
              height: AppSize.appheight * .1,
            ),
            const Center(
              child: Text(
                'connectez-vous avec',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF676767),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: AppSize.appheight * .05,
            ),
            Center(
                child: GestureDetector(
              onTap: () => controller.signInWithGoogle(),
              child: SvgPicture.asset(AppImages.google),
            )),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Text(
                  'En arrière',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
