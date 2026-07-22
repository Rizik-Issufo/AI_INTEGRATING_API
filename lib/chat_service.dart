import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static final Uri chatUri = Uri.parse('https://api.awanllm.com/v1/chat/completions');
  // final String apiKey =
  // 'LL-xHkAloKpeno3ipsma66EZsjzEBOBPSTXcDjnH4zfhwQrrpHacBR2VZ0SMKz8PaJP';
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 972fce92-2134-458d-ae08-0ff2bdd83d82',
  };

  Future<String?> request(String prompt) async {
    try {
      final request = ChatRequest(model: "Awabllm-Llama-3-8B-Dolfin", prompt: prompt);
      if (prompt.isEmpty) {
        return null;
      }
      final response = await http.post(chatUri,
          headers: headers, body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        final chatResponse = ChatResponse.fromJson(jsonDecode(response.body));
        return chatResponse.choices[0].text;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      print('Request failed: $e');
      return null;
    }
  }
}

class ChatRequest {
  final String model;
  final String prompt;

  ChatRequest({required this.model, required this.prompt});

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(
      model: json['model'],
      prompt: json['prompt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'prompt': prompt,
    };
  }
}

class ChatResponse {
  final List<Choice> choices;

  ChatResponse({required this.choices});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Choice.fromJson(e))
          .toList(),
    );
  }
}

class Choice {
  final String text;

  Choice({required this.text});

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'],
    );
  }
}
