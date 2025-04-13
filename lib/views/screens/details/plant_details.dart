import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/controllers/llmcontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/data/static/medicinelist.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:bio/views/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PlantDetails extends GetView<Homepagecontroller> {
  const PlantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LLMController());

    LLMController llmcontroller = Get.find();
    return Scaffold(
      body: SafeArea(
          child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        Hero(
                          tag:
                              "transition ${llmcontroller.currentplant.plantname}",
                          child: Container(
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth * .04,
                                bottom: constraints.maxHeight * .01),
                            height: constraints.maxHeight * .3,
                            width: constraints.maxWidth,
                            decoration: ShapeDecoration(
                                shape: const RoundedRectangleBorder(),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        llmcontroller.currentplant.image))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  llmcontroller.currentplant.plantname,
                                  style: const TextStyle(
                                      fontSize: 29,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: constraints.maxWidth * .02,
                                right: constraints.maxWidth * .02,
                                bottom: constraints.maxHeight * .01,
                                top: constraints.maxHeight * .02,
                              ),
                              height: constraints.maxHeight * .7,
                              width: constraints.maxWidth,
                              decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25)))),
                              child: Obx(
                                () => llmcontroller.isloading.value
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/lottie/loading.json'),
                                      )
                                    : llmcontroller.output.value != ""
                                        ? ListView(
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
                                                height:
                                                    constraints.maxHeight * .03,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: SvgPicture.asset(
                                                        AppImages.logo,
                                                        fit: BoxFit.contain,
                                                      )),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            .05,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Après avoir analysé votre sélection, l'IA a déterminé ...\n${llmcontroller.output.value}",
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
                                                height:
                                                    constraints.maxHeight * .1,
                                              )
                                            ],
                                          )
                                        : ListView(
                                            children: [
                                              ExpansionTile(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        side: BorderSide.none),
                                                title: const Text(
                                                  'Plant Monographie',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                childrenPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: constraints
                                                                .maxWidth *
                                                            .02,
                                                        vertical: 4),
                                                children: [
                                                  Text(
                                                    llmcontroller.currentplant
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            255, 95, 95, 95),
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        letterSpacing: .7),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: constraints.maxWidth *
                                                      .04,
                                                  right: constraints.maxWidth *
                                                      .02,
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      'Choisir un médicament',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.31,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 1.30,
                                                        letterSpacing: -0.52,
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    // IconButton(
                                                    //     onPressed: () {},
                                                    //     icon: const Icon(
                                                    //       Icons.search_outlined,
                                                    //       size: 23,
                                                    //     )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .02,
                                              ),
                                              Wrap(
                                                direction: Axis.horizontal,
                                                spacing: 14,
                                                runSpacing: 14,
                                                alignment: WrapAlignment.center,
                                                children: List.generate(
                                                    medicineList.length,
                                                    (index) {
                                                  final medcine =
                                                      medicineList[index];
                                                  return Obx(
                                                    () => GestureDetector(
                                                      onTap: () => controller
                                                          .selectedMedicine(
                                                              medcine),
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                                side: controller
                                                                            .selectedMedicine
                                                                            .value ==
                                                                        medcine
                                                                    ? BorderSide
                                                                        .none
                                                                    : const BorderSide(
                                                                        color: Colors
                                                                            .grey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color: Colors.white,
                                                            shadows: [
                                                              BoxShadow(
                                                                color: controller
                                                                            .selectedMedicine
                                                                            .value ==
                                                                        medicineList[
                                                                            index]
                                                                    ? Appcolors
                                                                        .primaryColor
                                                                    : Colors
                                                                        .grey,
                                                                blurRadius: 2,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .normal,
                                                              )
                                                            ]),
                                                        width: constraints
                                                                .maxWidth *
                                                            .29,
                                                        height: constraints
                                                                .maxHeight *
                                                            .05,
                                                        padding: EdgeInsets.only(
                                                            left: constraints
                                                                    .maxWidth *
                                                                .02),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            controller.selectedMedicine
                                                                        .value ==
                                                                    medcine
                                                                ? Flexible(
                                                                    child: GradientText(
                                                                        text:
                                                                            medcine,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight: FontWeight
                                                                                .w600),
                                                                        gradient:
                                                                            Appcolors.primaryGradient),
                                                                  )
                                                                : Flexible(
                                                                    child: Text(
                                                                      medcine,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .14,
                                              )
                                            ],
                                          ),
                              ),
                            )),
                        Positioned(
                          bottom: constraints.maxHeight * .03,
                          left: 0,
                          right: 0,
                          child: Obx(
                            () => llmcontroller.isloading.value
                                ? GradientBtnwithPrefix(
                                    gradient: Appcolors.primaryGradient,
                                    text: "Analyzing ...",
                                    onpress: () {})
                                : llmcontroller.output.value == ""
                                    ? GradientBtnwithPrefix(
                                        gradient: Appcolors.primaryGradient,
                                        text: "Commencez votre analyse",
                                        onpress: () {
                                          llmcontroller.getresponse(controller
                                              .selectedMedicine.value);
                                        })
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.appwidth * .04),
                                        child: GradientBtn(
                                            gradient: Appcolors.primaryGradient,
                                            text: "Terminer",
                                            onpress: () =>
                                                llmcontroller.clearOutput()),
                                      ),
                          ),
                        ),
                        Positioned(
                          left: constraints.maxWidth * .03,
                          top: constraints.maxHeight * .01,
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
                        )
                      ],
                    ),
                  ))),
    );
  }
}
