import 'package:bio/controllers/homepagecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/core/constants/size.dart';
import 'package:bio/data/homepage_views.dart';
import 'package:bio/models/plantmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Homepage extends GetView<Homepagecontroller> {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () =>
              Get.toNamed(AppRoutesNames.expressButton, arguments: {
            "plant": PlantModel(
                plantname: "", plantNameArab: "", description: "", image: "")
          }),
          child: SvgPicture.asset(
            AppImages.actionbtn,
            height: 80,
            width: 80,
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const Mynavbar(),
        body: GetBuilder<Homepagecontroller>(
            builder: (contr) => views[controller.currentpage]));
  }
}

class Mynavbar extends GetView<Homepagecontroller> {
  const Mynavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: AppSize.appheight * .01),
        child: Transform.scale(
          scale: .9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BottomAppBar(
              notchMargin: 16,
              shape: const CircularNotchedRectangle(),
              color: Colors.white,
              elevation: 16,
              shadowColor: Colors.grey,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSize.appwidth * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changePage(0),
                      child: GetBuilder<Homepagecontroller>(
                        builder: (contr) => Column(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 32,
                              color: controller.currentpage == 1
                                  ? Colors.grey
                                  : Appcolors.primaryColor,
                            ),
                            Text(
                              "Accueil",
                              style: TextStyle(
                                color: controller.currentpage == 1
                                    ? Colors.grey
                                    : Appcolors.primaryColor,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.19,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.changePage(1),
                      child: GetBuilder<Homepagecontroller>(
                        builder: (cont) => Column(
                          children: [
                            Icon(
                              Icons.account_circle_outlined,
                              size: 32,
                              color: controller.currentpage == 0
                                  ? Colors.grey
                                  : Appcolors.primaryColor,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: controller.currentpage == 0
                                    ? Colors.grey
                                    : Appcolors.primaryColor,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.19,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
