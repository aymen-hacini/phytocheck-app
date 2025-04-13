import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/controllers/profilecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/views/widgets/gradient_btn.dart';
import 'package:bio/views/widgets/role_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends GetView<Profilecontroller> {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Profilecontroller());
    Homepagecontroller homepagecontroller = Get.find();
    return Scaffold(
      body: SafeArea(
          child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        Obx(
                          () => ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: constraints.maxHeight * .07,
                                    left: constraints.maxWidth * .04),
                                child: const Text(
                                  "Mon Profile",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * .01,
                              ),
                              const Center(
                                child: Text(
                                  "Qu'est-ce que tu es ?",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: RoleDropdown(),
                              ),
                              controller.selectedRole.value ==
                                      "Professionnel de la santé"
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth * .04),
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller:
                                                controller.healthProName,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Appcolors
                                                                .primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                labelText: "Nom et prenom",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                hintText: "Ex: Chadli Ahmed...",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400])),
                                          ),
                                          SizedBox(
                                            height: constraints.maxHeight * .03,
                                          ),
                                          TextField(
                                            controller:
                                                controller.healthProfession,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Appcolors
                                                                .primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                labelText: "Profession",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                hintText:
                                                    "Ex: Medcin, Pharmacien, Dentiste, Infermier, labo...",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400])),
                                          ),
                                          SizedBox(
                                            height: constraints.maxHeight * .03,
                                          ),
                                          TextField(
                                            controller:
                                                controller.healthLieuTravail,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Appcolors
                                                                .primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                labelText: "Lieu de travail",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                hintText:
                                                    "Liberal/ Milieu Hospitalier",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400])),
                                          ),
                                          SizedBox(
                                            height: constraints.maxHeight * .03,
                                          ),
                                          TextField(
                                            controller: controller.healthAdress,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Appcolors
                                                                .primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                labelText: "Adresse",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                hintText:
                                                    "Ex: 150 logts cite ....",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400])),
                                          ),
                                          SizedBox(
                                            height: constraints.maxHeight * .03,
                                          )
                                        ],
                                      ),
                                    )
                                  : controller.selectedRole.value == "Patient"
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * .04),
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                    controller.patientNom,
                                                decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Appcolors
                                                                    .primaryColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    labelText: "Nom et prenom",
                                                    labelStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    hintText:
                                                        "Ex: Chadli Ahmed...",
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[400])),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .03,
                                              ),
                                              TextField(
                                                controller:
                                                    controller.patientAge,
                                                decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Appcolors
                                                                    .primaryColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    labelText: "Age",
                                                    labelStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    hintText: "Ex: 20",
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[400])),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .03,
                                              ),
                                              TextField(
                                                controller: controller
                                                    .patientLieuResidence,
                                                decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Appcolors
                                                                    .primaryColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20)),
                                                    labelText:
                                                        "Lieu de residence",
                                                    labelStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    hintText: "Wilaya/Baladiya",
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[400])),
                                              ),
                                              SizedBox(
                                                height:
                                                    constraints.maxHeight * .03,
                                              ),
                                            ],
                                          ),
                                        )
                                      : controller.selectedRole.value == ""
                                          ? const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                              SizedBox(
                                height: constraints.maxHeight * .03,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => controller.isloading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Appcolors.primaryColor,
                                          ),
                                        )
                                      : GradientBtn(
                                          gradient: Appcolors.primaryGradient,
                                          text: "Soumettre",
                                          onpress: () {
                                            controller.selectedRole.value ==
                                                    "Patient"
                                                ? homepagecontroller
                                                    .changeProfessional(false)
                                                : controller.selectedRole
                                                            .value ==
                                                        "Professionnel de la santé"
                                                    ? homepagecontroller
                                                        .changeProfessional(
                                                            true)
                                                    : null;

                                            if (controller
                                                .selectedRole.isNotEmpty) {
                                              controller.updateDocument(
                                                  additionalFields: {
                                                    "Nom et prenom": controller
                                                                .selectedRole
                                                                .value ==
                                                            "Professionnel de la santé"
                                                        ? controller
                                                            .healthProName.text
                                                            .trim()
                                                        : controller
                                                            .patientNom.text
                                                            .trim(),
                                                    "Type": controller
                                                        .selectedRole.value,
                                                    "Profession": controller
                                                        .healthProfession.text
                                                        .trim(),
                                                    "Lieu de travail":
                                                        controller
                                                            .healthLieuTravail
                                                            .text
                                                            .trim(),
                                                    "Adresse": controller
                                                                .selectedRole
                                                                .value ==
                                                            "Professionnel de la santé"
                                                        ? controller
                                                            .healthAdress.text
                                                            .trim()
                                                        : controller
                                                            .patientLieuResidence
                                                            .text
                                                            .trim(),
                                                    "Age": controller
                                                        .patientAge.text
                                                        .trim()
                                                  });
                                            }
                                          }),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
