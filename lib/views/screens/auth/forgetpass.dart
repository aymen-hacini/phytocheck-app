import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpass extends GetView<Homepagecontroller> {
  const Forgetpass({super.key});

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
        child: Form(
          key: GlobalKey(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mot de passe\n oublié ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                  height: 1.19,
                ),
              ),
              SizedBox(
                height: AppSize.appheight * .03,
              ),
              TextFormField(
                controller: controller.emailcontrollerForgetpass,
                validator: (v) {
                  if (GetUtils.isEmail(v!)) {
                    return "Veuillez saisir une adresse e-mail correcte";
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
                      Icons.mail_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                    hintText: "Entrez votre adresse e-mail",
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 14)),
              ),
              SizedBox(
                height: AppSize.appheight * .02,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF676767)),
                  children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextSpan(
                        text:
                            ' Nous vous enverrons un message pour définir ou réinitialiser votre nouveau mot de passe'),
                  ],
                ),
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
                              onpress: () => controller.sendPasswordReset())
                        ],
                      ),
              ),
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
      ),
    );
  }
}
