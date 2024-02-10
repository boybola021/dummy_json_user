
import 'dart:convert';

import 'package:dummy_json_user/models/user_model.dart';
import 'package:dummy_json_user/servise/network_servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("User test", () {
    test("Users  ", ()async{
      final String? respone = await Network.getMethod(api: Network.apiUsers);
      final json = jsonDecode(respone!) as Map;
      final users = json["users"] as List;
      final model = users.map((e){
        final item = e as Map;
        return User.fromJson(item as Map<String,Object?>);
      }).toList();
      /// parse
      List<User> list = users.map((e) => User.fromJson(e as Map<String,Object?>)).toList();
      debugPrint(list.toString());
      expect(model, const TypeMatcher<List<User>>());
    });
    test("Users", ()async{
      final String? respone = await Network.getMethod(api: Network.apiUsers);
      final json = jsonDecode(respone!) as Map;
      final users = json["users"] as List;
      final model = users.map((e){
        final item = e as Map;
        return User.fromJson(item as Map<String,Object?>);
      }).toList();
      /// parse
      List<User> list = users.map((e) => User.fromJson(e as Map<String,Object?>)).toList();
      debugPrint(list.toString());
      expect(model, const TypeMatcher<List<User>>());
    });
  });
}