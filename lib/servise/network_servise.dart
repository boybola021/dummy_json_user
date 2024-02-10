import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

sealed class Network {
  static const String baseUrl = "dummyjson.com";
  static String apiUsers= "/users";
  static String apiAdd = "/users/add";
  static String search = "/search";
  static const Map<String, String> header = {
    "Content-Type": "application/json",
  };

  /// GET
  static Future<String?> getMethod({
    required String api,
    Object? id,
    String baseUrl = baseUrl,
    Map<String,String>? query,
  }) async {
    Uri url = Uri.https(baseUrl, "$api/${id ?? ""}",query);
    try {
      final response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  /// POST
  static Future<void> postMethod({
    required String api,
    String baseUrl = baseUrl,
    required Map<String,Object?> data,
  }) async {
    Uri url = Uri.https(baseUrl, api);
    try {
      final response = await http.post(url,body: jsonEncode(data),headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// PUT
   static Future<void> putMethod({
    required String api,
    required Map<String,Object?> data,
     required Object id,
     String baseUrl = baseUrl,
   }) async {
    Uri url = Uri.https(baseUrl, "$api/$id");
    try {
      final response = await http.put(url,body: jsonEncode(data),headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  /// DELATE
 static Future<void> delateMethod({
    required String api,
     required Object id,
     String baseUrl = baseUrl,
   }) async {
    Uri url = Uri.https(baseUrl, "$api/$id");
    try {
      final response = await http.delete(url,headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


   /// search

  static Future<String?> searchMethod({
    required String api,
    String baseUrl = baseUrl,
    required Map<String,String> query,
  }) async {
    Uri url = Uri.https(baseUrl, api,query);
    try {
      final response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      return null;
    }
    return null;

  }

  static List<User>userModelList(String data){
    final json = jsonDecode(data)["users"] as List;
    return json.map((e) => User.fromJson(e as Map<String,Object?>)).toList();
  }

  static ApiRespone apiResponseParse(String data){
    final json = jsonDecode(data) as Map;
    return ApiRespone.fromJson(json as Map<String,Object?>);
  }
}

