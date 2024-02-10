

import 'dart:convert';

import 'package:dummy_json_user/models/user_model.dart';
import 'package:dummy_json_user/servise/network_servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("Companiy test", () {
    test("compani api ", ()async{
      final String? respone = await Network.getMethod(api: Network.apiUsers);
      final json = jsonDecode(respone!) as Map;
      final users = json["users"] as List;
      final company = users.map((e){
        final item = e as Map;
        final respons = item["company"] as Map<String,Object?>;
        return Company.fromJson(respons);
      }).toList();
      debugPrint(company.toString());
      expect(company, const TypeMatcher<List<Company>>());
    });
  });
}