
import 'package:flutter/material.dart';
import 'package:study/view/card/WordCard.dart';
import 'package:study/view/detali/index.dart';
import 'package:study/view/index.dart';


class Routes{

  Map<String, WidgetBuilder> init(){
    return {
      '/' : (c) => Index(),
      '/word/detail':(c) => DetailIndex(argsFromContext(c)),
      '/word/card':(c) => WordCard(argsFromContext(c)),
    };
  }

  dynamic argsFromContext(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }
}