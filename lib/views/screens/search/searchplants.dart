import 'package:bio/controllers/searchcontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:bio/core/constants/images.dart';
import 'package:bio/core/constants/routes_names.dart';
import 'package:bio/data/static/medicinelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Searchplants extends GetView<Searchcontroller> {
  const Searchplants({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Searchcontroller());
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
                                TextSpan(text: "Rechercher "),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: Text(
                                      "une plante",
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
                          child: const Text("nom français ou arabe",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * .02),
                          child: TextFormField(
                              onChanged: (s) =>
                                  controller.searchPlants(s.trim(), plantsList),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Appcolors.primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: const Icon(Icons.search_outlined),
                                hintText:
                                    "Entrez le nom de la plante que vous souhaitez rechercher",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              )),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * .02,
                        ),
                        Obx(
                          () => controller.isloading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Appcolors.primaryColor,
                                  ),
                                )
                              : controller.results.isEmpty
                                  ? Center(
                                      child: Lottie.asset(
                                          "assets/lottie/empty.json"),
                                    )
                                  : Expanded(
                                      child: GridView.builder(
                                          itemCount: controller.results.length,
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  constraints.maxHeight * .02,
                                              horizontal:
                                                  constraints.maxWidth * .02),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 9 / 11,
                                                  crossAxisSpacing: 14,
                                                  mainAxisSpacing: 14),
                                          itemBuilder: (context, index) {
                                            final currentplant =
                                                controller.results[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutesNames.plantDetails,
                                                    arguments: {
                                                      "plant": currentplant
                                                    });
                                              },
                                              child: Container(
                                                decoration: ShapeDecoration(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        32)),
                                                    color: Colors.white,
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 1,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            Color(0x16000000),
                                                        blurRadius: 2,
                                                        offset: Offset(2, 2),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            Color(0x0C000000),
                                                        blurRadius: 3,
                                                        offset: Offset(4, 4),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            Color(0x02000000),
                                                        blurRadius: 4,
                                                        offset: Offset(6, 6),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            Color(0x00000000),
                                                        blurRadius: 4,
                                                        offset: Offset(10, 10),
                                                        spreadRadius: 0,
                                                      ),
                                                    ]),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(32),
                                                        topLeft:
                                                            Radius.circular(32),
                                                        bottomLeft:
                                                            Radius.circular(16),
                                                        bottomRight:
                                                            Radius.circular(16),
                                                      ),
                                                      child: Hero(
                                                        tag:
                                                            "transition ${currentplant.plantname}",
                                                        child: Image.asset(
                                                          currentplant.image,
                                                          fit: BoxFit.cover,
                                                          height: constraints
                                                                  .maxHeight *
                                                              .25,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 0,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: constraints
                                                                      .maxWidth *
                                                                  .04,
                                                              right: constraints
                                                                      .maxWidth *
                                                                  .04,
                                                              bottom: constraints
                                                                      .maxHeight *
                                                                  .02),
                                                          child: Text(
                                                            currentplant
                                                                .plantname,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                        )),
                                                    Positioned(
                                                        bottom: constraints
                                                                .maxHeight *
                                                            .013,
                                                        right: constraints
                                                                .maxWidth *
                                                            .03,
                                                        child: SvgPicture.asset(
                                                            AppImages.magicbtn))
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
