import 'package:bio/core/constants/api.dart';
import 'package:bio/models/llm_response.dart';
import 'package:dio/dio.dart';

class LLMService {
  static const String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String _apiKey = ApiLinkNames.deepSeekKey;

  final Dio _dio = Dio();

  Future<LLMResponse> fetchLLMResponse(String prompt) async {
    final data = {
      "model": "deepseek/deepseek-chat-v3-0324:free",
      "messages": [
        {"role": "user", "content": prompt}
      ]
    };
    try {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        responseHeader: true,
      ));
      final response = await _dio.post(
        _apiUrl,
        options: Options(
          preserveHeaderCase: true,
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        String fullResponse = response.data['choices'][0]['message']['content'];

        // Remove the original prompt from the response
        // String cleaned = fullResponse.replaceFirst("$prompt :", '').trim();
        return LLMResponse(generatedText: fullResponse);
      } else {
        print(response.data);
        throw Exception('Failed: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
