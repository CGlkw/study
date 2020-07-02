
import 'package:flutter/material.dart';
import 'package:study/view/detali/detail.dart';
import 'package:study/view/index.dart';


class Routes{

  Map<String, WidgetBuilder> init(){
    return {
      '/' : (c) => Index(),
      '/word/detail':(c) => WordDetail(argsFromContext(c)),
    };
  }

  dynamic argsFromContext(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }
}