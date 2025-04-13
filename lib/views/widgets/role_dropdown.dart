import 'package:bio/controllers/profilecontroller.dart';
import 'package:bio/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? selectedRole;

  final List<String> roles = ['Professionnel de la santé', 'Non professionnel de santé'];

  @override
  Widget build(BuildContext context) {
    Profilecontroller controller = Get.find();
    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.grey))),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(20),
          value: selectedRole,
          hint: const Text('Sélectionner un rôle'),
          items: roles.map((String role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              controller.selectedRole.value = newValue!;
              selectedRole = newValue;

              if (newValue == "Professionnel de la santé") {
                PanaraInfoDialog.show(
                  context,
                  title: "Important",
                  message:
                      '''En tant que professionnel de santé, vous pouvez nous signaler tout cas d’interaction plante-médicament observé.\nVotre retour contribue à l’évolution continue de l’application.''',
                  buttonText: "Fermer",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.success,
                  color: Appcolors.primaryColor,
                );
              }
            });
          },
        ),
      ),
    );
  }
}
