
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:study/utils/SpUtils.dart';

class YouDaoApi {
  //static const String baseUrl = "http://127.0.0.1:8000";

  static const String key = "mdict.8.2.6.android";

  static const String cipherKey = "ydsecret://query.token/signkey/ioHOsiqdVRrm@T!h!b9@pBf&YrE5FPe0I7qAup6WL^9AV16J4J";

  Map<String, dynamic> getSign(String q){
    String i = "${currentTimeMillis() ~/ 10}";
    String s = q + key;
    String t = "$i${s.length % 10}";
    String keyMd5 = generateMd5(s);
    String p1 = "mobile$q$t";

    String sign = generateMd5("$p1$cipherKey$keyMd5");
    return {
      "t":t,
      "sign":sign,
      "client":"mobile",
      "keyversion":"20171115",
      "keyfrom":key
    };
  }

  static const String baseUrl = "http://dict.youdao.com";

  Dio dio = Dio ();

  Future<Map<String,dynamic>> search (String query) async {
    String buffer = await SpUtils.getStr("search_$query");
    if(buffer != null){
      return json.decode(buffer) as Map;
    }

    Map<String, dynamic> param = {
      "num":15,
      "ver":"3.0",
      "q":query,
      "doctype":"json"
    };
    Response result = await dio.get(baseUrl+"/suggest",queryParameters: param);
    SpUtils.setStr("search_$query", json.encode(result.data));
    return result.data;
  }

  Future<Map<String,dynamic>> detail (String query) async {
    String buffer = await SpUtils.getStr("detail_$query");
    if(buffer != null){
      return json.decode(buffer) as Map;
    }

    Map<String, dynamic> param = {
      "q":query,
      "jsonversion":3
    }..addAll(getSign(query));
    Response result = await dio.get(baseUrl+"/jsonapi_s",queryParameters: param);
    SpUtils.setStr("detail_$query", json.encode(result.data));
    return result.data;
  }

  int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}