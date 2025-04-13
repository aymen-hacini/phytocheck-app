import 'package:bio/core/services/llmservice.dart';
import 'package:bio/models/plantmodel.dart';
import 'package:get/get.dart';

import '../models/llm_response.dart';

class LLMController extends GetxController {
  final LLMService _service = LLMService();

  var isloading = false.obs;

  late PlantModel currentplant;
  late PlantModel expressplant;
  late String expressMedicament;

  RxString output = "".obs;

  Future<String> generateText(String prompt) async {
    try {
      isloading(true);
      LLMResponse response = await _service.fetchLLMResponse(prompt);
      print(response.generatedText);
      return response.generatedText;
    } catch (e) {
      return 'Error: $e';
    } finally {
      isloading(false);
    }
  }


  getresponse(String medicament) async {
    final response = await generateText(
        "Your are a biological expert and a pharmacist , Does ${currentplant.plantname} have an interaction with $medicament ? answer with yes or no, then tell me the inhibteur,inductor and synergique effects, including the symptoms if it's not good and benefits if it is good and show it in bulletpoints dont exceed 12 lines. Respond only in french");

    output.value = response;
  }

  getExpressreponse() async {
    final response = await generateText(
        "Your are a biological expert and a pharmacist , Does ${expressplant.plantname} have an interaction with $expressMedicament ? answer with yes or no, then tell me the inhibteur,inductor and synergique effects, including the symptoms if it's not good and benefits if it is good and show it in bulletpoints dont exceed 12 lines. Respond only in french");

    output.value = response;
  }

  clearOutput() async {
    output.value = "";
  }

  @override
  void onInit() {
    currentplant = Get.arguments['plant'];
    super.onInit();
  }
}
