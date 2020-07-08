
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:study/utils/SpUtils.dart';

class YouDaoApi {
  static const String baseUrl = "http://127.0.0.1:8000";
  //static const String baseUrl = "http://dict.youdao.com";

  Dio dio = Dio ();

  Future<Map<String,dynamic>> search (String query) async {
//    String buffer = await SpUtils.getStr("search_$query");
//    if(buffer != null){
//      return json.decode(buffer) as Map;
//    }

    Map<String, dynamic> param = {
      "num":15,
      "ver":"3.0",
      "q":query,
      "doctype":"json"
    };
    Response result = await dio.get(baseUrl+"/suggest",queryParameters: param);
    //SpUtils.setStr("search_$query", json.encode(result.data));
    return result.data;
  }

  Future<Map<String,dynamic>> detail (String query) async {
//    String buffer = await SpUtils.getStr("detail_$query");
//    if(buffer != null){
//      return json.decode(buffer) as Map;
//    }

    Map<String, dynamic> param = {
      "q":query,
      "jsonversion":3
    };
    Response result = await dio.get(baseUrl+"/jsonapi_s",queryParameters: param);
    //SpUtils.setStr("detail_$query", json.encode(result.data));
    return result.data;
  }
}