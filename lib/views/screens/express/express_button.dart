import 'package:bio/controllers/llmcontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:bio/views/widgets/medicament_dropdown.dart';
import 'package:bio/views/widgets/plant_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ExpressButton extends GetView<LLMController> {
  const ExpressButton({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LLMController());
    return Scaffold(
      body: SafeArea(
          child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: constraints.maxHeight * .02,
                            left: constraints.maxWidth * .02,
                          ),
                          child: IconButton(
                              style: IconButton.styleFrom(
                                  shadowColor: Colors.grey,
                                  backgroundColor: Colors.white,
                                  elevation: 5),
                              onPressed: () => Get.back(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 22,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * .02,
                          ),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontSize: 27,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                              children: [
                                TextSpan(text: "Analyse "),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: Text(
                                      "Rapide",
                                      style: TextStyle(
                                          height: .1,
                                          fontSize: 27,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Appcolors.primaryColor),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: constraints.maxHeight * .02,
                            left: constraints.maxWidth * .03,
                          ),
                          child: const Text(
                              " Sélectionnez une plante et un médicament",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * .02),
                          child: const PlantDropdown(),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * .02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * .02),
                          child: const MedicamentDropdown(),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * .02,
                        ),
                        Obx(
                          () => controller.isloading.value
                              ? Center(
                                  child: Lottie.asset(
                                      'assets/lottie/loading.json'),
                                )
                              : controller.output.value != ""
                                  ? Expanded(
                                      child: ListView(
                                        children: [
                                          const Center(
                                              child: Text(
                                            'Vos résultats',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.26,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              height: 1.40,
                                            ),
                                          )),
                                          SizedBox(
                                            height: constraints.maxHeight * .03,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: SvgPicture.asset(
                                                      AppImages.logo,
                                                      fit: BoxFit.contain,
                                                    )),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * .05,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Après avoir analysé votre sélection, l'IA a déterminé ...\n${controller.output.value}",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: constraints.maxHeight * .1,
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller.isloading.value
                              ? GradientBtnwithPrefix(
                                  gradient: Appcolors.primaryGradient,
                                  text: "Analyzing ...",
                                  onpress: () {})
                              : controller.output.value == ""
                                  ? GradientBtnwithPrefix(
                                      gradient: Appcolors.primaryGradient,
                                      text: "Commencez votre analyse",
                                      onpress: () =>
                                          controller.getExpressreponse())
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppSize.appwidth * .04),
                                      child: GradientBtn(
                                          gradient: Appcolors.primaryGradient,
                                          text: "Terminer",
                                          onpress: () =>
                                              controller.clearOutput()),
                                    ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * .05,
                        )
                      ],
                    ),
                  ))),
    );
  }
}
