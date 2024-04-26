import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:chatgtp/views/imagegenrration.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static final ApiHelper apiHelper = ApiHelper._();
  String? ans;

  textgenerationapi({required String text}) async {
    Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": "hy"}
          ]
        },
        {
          "role": "model",
          "parts": [
            {"text": "Hi! How can I help you today? 😊"}
          ]
        },
        {
          "role": "user",
          "parts": [
            {
              "text": text,
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.9,
        "topK": 1,
        "topP": 1,
        "maxOutputTokens": 2048,
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        }
      ]
    };
    http.Response response = await http.post(
        Uri.parse(
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=AIzaSyArA6jqmqupmggvWhc2GFxjTXDFaJvsZJA"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      var ans = jsonDecode(response.body);
      log("${ans['candidates'][0]['content']['parts'][0]['text']}");
      ans = "${ans['candidates'][0]['content']['parts'][0]['text']}";
      return ans;
    } else {
      return null;
    }
  }

  imageapi({required String question}) async {
    try {
      final dio = Dio();

      Map<String, dynamic> payload = {
        'prompt': question,
        'style_id': '28',
      };
      FormData formData = FormData.fromMap(payload);

      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-Df24tfJyYFSDWSNyITL5cfDBNEqt26xwZ2Qn3sE1oJe0w'
      };
      dio.options =
          BaseOptions(headers: headers, responseType: ResponseType.bytes);

      final response = await dio.post(
          "https://api.vyro.ai/v1/imagine/api/generations",
          data: formData);

      print("---------${response.statusCode}");
      print("---------${response.data.toString()}");

      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
