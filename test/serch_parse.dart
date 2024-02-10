

import 'dart:convert';

import 'package:dummy_json_user/servise/network_servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("serch parse", ()async{
    final String? respone = await Network.searchMethod(api: Network.apiUsers, query: {"q" : "John"});
    final json = jsonDecode(respone!) as Map;
    debugPrint(json.toString());
  });
}