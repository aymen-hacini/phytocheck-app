class LLMResponse {
  final String generatedText;

  LLMResponse({required this.generatedText});

  factory LLMResponse.fromJson(Map<String, dynamic> json) {
    return LLMResponse(generatedText: json['generated_text']);
  }
}
