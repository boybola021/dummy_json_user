

import 'dart:convert';

import 'package:dummy_json_user/models/user_model.dart';
import 'package:dummy_json_user/servise/network_servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("Address test", () {
    test("Address  ", ()async{
      final String? respone = await Network.getMethod(api: Network.apiUsers);
      final json = jsonDecode(respone!) as Map;
      final users = json["users"] as List;

      final bank = users.map((e){
        final item = e as Map;
        final address = item["address"] as Map<String,Object?>;
        return Address.fromJson(address);
      }).toList();
      debugPrint(bank.toString());
      expect(bank, const TypeMatcher<List<Address>>());
    });
  });
}