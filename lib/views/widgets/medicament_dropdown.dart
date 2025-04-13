import 'package:bio/controllers/llmcontroller.dart';
import 'package:bio/data/static/medicinelist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicamentDropdown extends StatefulWidget {
  const MedicamentDropdown({super.key});

  @override
  _MedicamentDropdownState createState() => _MedicamentDropdownState();
}

class _MedicamentDropdownState extends State<MedicamentDropdown> {
  // This is the selected role variable
  String? selectedMedicament;

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
        child: DropdownButton<String>(
          menuWidth: Get.context!.width * .7,
          borderRadius: BorderRadius.circular(20),
          value: selectedMedicament,
          hint: const Text('Sélectionnez une medicament'),
          items: medicineList.map((String medicament) {
            return DropdownMenuItem<String>(
              value: medicament,
              child: Text(medicament),
            );
          }).toList(),
          onChanged: (String? medicament) {
            setState(() {
              selectedMedicament = medicament;
              controller.expressMedicament = medicament!;
            });
          },
        ),
      ),
    );
  }
}
