import 'package:bio/models/plantmodel.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController {
  RxList<PlantModel> results = <PlantModel>[].obs;

  var isloading = false.obs;


  void searchPlants(String query, List<PlantModel> plantsList) {
    try {
      isloading(true);
      results.value = plantsList.where((plant) {
        final lowerQuery = query.toLowerCase();


        return plant.plantname.toLowerCase().contains(lowerQuery) ||
            plant.plantNameArab.contains(lowerQuery);
      }).toList();
    } finally {
      isloading(false);
      
    }
  }


}
