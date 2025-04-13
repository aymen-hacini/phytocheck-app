import 'package:bio/controllers/llmcontroller.dart';
import 'package:bio/data/static/medicinelist.dart';
import 'package:bio/models/plantmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantDropdown extends StatefulWidget {
  const PlantDropdown({super.key});

  @override
  _PlantDropdownState createState() => _PlantDropdownState();
}

class _PlantDropdownState extends State<PlantDropdown> {
  // This is the selected role variable
  PlantModel? selectedPlant;

  @override
  Widget build(BuildContext context) {
    LLMController controller = Get.find();

    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        width: double.infinity,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.grey))),
        child: DropdownButton<PlantModel>(
          menuWidth: Get.context!.width * .7,
          borderRadius: BorderRadius.circular(20),
          value: selectedPlant,
          hint: const Text('Sélectionnez une plante'),
          items: plantsList.map((PlantModel plant) {
            return DropdownMenuItem<PlantModel>(
              value: plant,
              child: Text(plant.plantname),
            );
          }).toList(),
          onChanged: (PlantModel? plant) {
            setState(() {
              selectedPlant = plant;
              controller.expressplant = plant!;
            });
          },
        ),
      ),
    );
  }
}
