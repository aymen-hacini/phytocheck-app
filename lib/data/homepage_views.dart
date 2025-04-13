import 'dart:convert';

import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/data/static/medicinelist.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:bio/views/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> views = [const HomeTab(), const ProfileTab()];

class HomeTab extends GetView<Homepagecontroller> {
  const HomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: constraints.maxWidth * .04,
                        right: constraints.maxWidth * .04,
                        top: constraints.maxHeight * .06,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 27,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                              children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: Obx(
                                      () => Text(
                                        "${controller.userModel.value?.displayName ?? controller.userModel.value?.email.substring(0, 5) ?? ""},\n",
                                        style: const TextStyle(
                                            height: .1,
                                            fontSize: 27,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            color: Appcolors.primaryColor),
                                      ),
                                    )),
                                const TextSpan(
                                  text: '\nBienvenue à nouveau',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () =>
                                  Get.toNamed(AppRoutesNames.searchScreen),
                              icon: const Icon(
                                Icons.search_outlined,
                                size: 28,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .05,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Sélectionnez une plante',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.38,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: plantsList.length,
                            padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * .02,
                                horizontal: constraints.maxWidth * .02),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 9 / 11,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14),
                            itemBuilder: (context, index) {
                              final currentplant = plantsList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutesNames.plantDetails,
                                      arguments: {"plant": currentplant});
                                },
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      color: Colors.white,
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x16000000),
                                          blurRadius: 2,
                                          offset: Offset(2, 2),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x0C000000),
                                          blurRadius: 3,
                                          offset: Offset(4, 4),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x02000000),
                                          blurRadius: 4,
                                          offset: Offset(6, 6),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x00000000),
                                          blurRadius: 4,
                                          offset: Offset(10, 10),
                                          spreadRadius: 0,
                                        ),
                                      ]),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32),
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        child: Hero(
                                          tag:
                                              "transition ${currentplant.plantname}",
                                          child: Image.asset(
                                            currentplant.image,
                                            fit: BoxFit.cover,
                                            height: constraints.maxHeight * .25,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    constraints.maxWidth * .04,
                                                right:
                                                    constraints.maxWidth * .04,
                                                bottom: constraints.maxHeight *
                                                    .02),
                                            child: Text(
                                              currentplant.plantname,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: "Poppins"),
                                            ),
                                          )),
                                      Positioned(
                                          bottom: constraints.maxHeight * .013,
                                          right: constraints.maxWidth * .03,
                                          child: SvgPicture.asset(
                                              AppImages.magicbtn))
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              )),
    );
  }
}

class ProfileTab extends GetView<Homepagecontroller> {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(),
                            gradient: Appcolors.primaryGradient),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: constraints.maxHeight * .01,
                            left: constraints.maxWidth * .06,
                            right: constraints.maxWidth * .01),
                        child: Row(
                          children: [
                            const Text(
                              "Mon Profile",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 21,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            PopupMenuButton(
                                color: Colors.white,
                                iconColor: Colors.white,
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: "Log Out",
                                        child: const Text("Log Out"),
                                        onTap: () => controller.signOut(),
                                      )
                                    ])
                          ],
                        ),
                      ),
                      Positioned(
                          top: constraints.maxHeight * .1,
                          left: constraints.maxWidth * .35,
                          child: GestureDetector(
                            onTap: () => controller.pickImage(),
                            child: Obx(
                              () {
                                final photourlexists =
                                    controller.userModel.value?.photoUrl ?? "";
                                return controller.userModel.value?.photoUrl !=
                                        ""
                                    ? CircleAvatar(
                                        backgroundImage: photourlexists
                                                .startsWith("https://")
                                            ? NetworkImage(controller.userModel
                                                    .value?.photoUrl ??
                                                "")
                                            : MemoryImage(base64Decode(
                                                controller.userModel.value
                                                        ?.photoUrl ??
                                                    "")),
                                        radius: 60,
                                      )
                                    : const CircleAvatar(
                                        backgroundImage:
                                            AssetImage(AppImages.plant),
                                        radius: 60,
                                      );
                              },
                            ),
                          )),
                      Positioned(
                          top: constraints.maxHeight * .21,
                          left: constraints.maxWidth * .54,
                          child: Transform.scale(
                            scale: .5,
                            child: IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: Appcolors.primaryColor,
                                )),
                          )),
                      Positioned(
                          top: constraints.maxHeight * .32,
                          left: constraints.maxWidth * .4,
                          child: Obx(
                            () => Text(
                              controller.userModel.value?.displayName ??
                                  controller.userModel.value?.email
                                      .substring(0, 5) ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Poppins"),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          height: constraints.maxHeight * .6,
                          width: constraints.maxWidth,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(43),
                                      topRight: Radius.circular(43)))),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () =>
                                    Get.toNamed(AppRoutesNames.myprofile),
                                leading: SvgPicture.asset(AppImages.profile),
                                title: const Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 75, 75, 75)),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                leading: SvgPicture.asset(AppImages.terms),
                                title: const Text(
                                  "Conditions et politique",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 75, 75, 75)),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  dialPhoneNumber("+213666873135");
                                },
                                leading: SvgPicture.asset(AppImages.center),
                                title: const Text(
                                  "Centre de service",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 75, 75, 75)),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * .06,
                              ),
                              Obx(
                                () => controller.isProfessional.value
                                    ? GradientBtn(
                                        gradient: Appcolors.primaryGradient,
                                        text: "Ajouter une declaration",
                                        onpress:
                                            () => Get.bottomSheet(Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  height:
                                                      constraints.maxHeight *
                                                          .6,
                                                  width: constraints.maxWidth,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          32),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          32)))),
                                                  child: Column(
                                                    children: [
                                                      const GradientText(
                                                          text:
                                                              "Votre déclaration",
                                                          style: TextStyle(
                                                              fontSize: 28,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              letterSpacing:
                                                                  1.2),
                                                          gradient: Appcolors
                                                              .primaryGradient),
                                                      Expanded(
                                                        child: ListView(
                                                          children: [
                                                            TextField(
                                                              controller: controller
                                                                  .declarationPlant,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Entrer le nom de la plante",
                                                                  labelText:
                                                                      "Nom de la plante",
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .grey)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(
                                                                          color: Appcolors
                                                                              .primaryColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                            ),
                                                              
                                                            SizedBox(
                                                              height: constraints
                                                                      .maxHeight *
                                                                  .02,
                                                            ),
                                                            TextField(
                                                              controller: controller
                                                                  .declarationPlantDescription,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Ex: Partie Utilise (racine,tige...), Mode D'utilisation (Infusion/Decoction/Extrait sec), Raison D'utilisation , Periode d'utilisation ( Avant/Apres/Durant treatment)",
                                                                  labelText:
                                                                      "Description du cas",
                                                                  floatingLabelAlignment:
                                                                      FloatingLabelAlignment
                                                                          .start,
                                                                  alignLabelWithHint:
                                                                      true,
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .grey)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(
                                                                          color: Appcolors
                                                                              .primaryColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                              maxLines: 5,
                                                            ),
                                                            SizedBox(
                                                              height: constraints
                                                                      .maxHeight *
                                                                  .02,
                                                            ),
                                                            TextField(
                                                              controller: controller
                                                                  .declarationCasDescription,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Ex : Antecedents, Age, Symptomes, TRT, Posologie ...",
                                                                  labelText:
                                                                      "Antecedents du patient",
                                                                  alignLabelWithHint:
                                                                      true,
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .grey)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(
                                                                          color: Appcolors
                                                                              .primaryColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                              maxLines: 4,
                                                            ),
                                                            
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: constraints
                                                                .maxHeight *
                                                            .04,
                                                      ),
                                                      Obx(
                                                        () => controller
                                                                .isLoading.value
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Appcolors
                                                                      .primaryColor,
                                                                ),
                                                              )
                                                            : GradientBtn(
                                                                gradient: Appcolors
                                                                    .primaryGradient,
                                                                text:
                                                                    "Envoyez votre déclaration",
                                                                onpress: () {
                                                                  controller
                                                                      .addDeclaration({
                                                                    "Plant name": controller
                                                                        .declarationPlant
                                                                        .text
                                                                        .trim(),
                                                                    "Plant description": controller
                                                                        .declarationPlantDescription
                                                                        .text
                                                                        .trim(),
                                                                    "Cas Description":
                                                                        controller
                                                                            .declarationCasDescription
                                                                            .text
                                                                            .trim()
                                                                  });
                                                                  controller
                                                                      .declarationPlant
                                                                      .clear();
                                                                  controller
                                                                      .declarationPlantDescription
                                                                      .clear();
                                                                  controller
                                                                      .declarationCasDescription
                                                                      .clear();
                                                                  Get.back();
                                                                }),
                                                      )
                                                    ],
                                                  ),
                                                )))
                                    : GradientBtn(
                                        gradient: Appcolors.primaryGradient,
                                        text: "Ajouter un rapport de Feedback",
                                        onpress: () =>
                                            Get.bottomSheet(Container(
                                              padding: const EdgeInsets.all(16),
                                              height:
                                                  constraints.maxHeight * .6,
                                              width: constraints.maxWidth,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(32),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      32)))),
                                              child: Column(
                                                children: [
                                                  const GradientText(
                                                      text: "Votre Feedback",
                                                      style: TextStyle(
                                                          fontSize: 28,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          letterSpacing: 1.2),
                                                      gradient: Appcolors
                                                          .primaryGradient),
                                                  TextField(
                                                    controller:
                                                        controller.feedbackText,
                                                    decoration: InputDecoration(
                                                        hintText: "...",
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(
                                                                color: Appcolors
                                                                    .primaryColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    maxLines: 8,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        constraints.maxHeight *
                                                            .04,
                                                  ),
                                                  Obx(
                                                    () => controller
                                                            .isLoading.value
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Appcolors
                                                                  .primaryColor,
                                                            ),
                                                          )
                                                        : GradientBtn(
                                                            gradient: Appcolors
                                                                .primaryGradient,
                                                            text:
                                                                "Envoyer votre Feedback",
                                                            onpress: () {
                                                              controller
                                                                  .addFeedback({
                                                                "Feedback":
                                                                    controller
                                                                        .feedbackText
                                                                        .text
                                                                        .trim()
                                                              });
                                                              controller
                                                                  .feedbackText
                                                                  .clear();
                                                            }),
                                                  )
                                                ],
                                              ),
                                            ))),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )));
  }
}

void dialPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}
