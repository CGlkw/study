
import 'package:flutter/material.dart';

class ParsePLabel{

  TextStyle textStyle;
  TextStyle pTextStyle;

  ParsePLabel({this.textStyle, this.pTextStyle});

  RichText parse(String string){

    List<TextSpan> list = [];

    while(true){
      int indexP = string.indexOf("<b>");
      if(indexP == -1){
        list.add(TextSpan(
          text: string,
        ));
        break;
      }else {
        int index_P = string.indexOf("</b>");
        if(index_P == -1){
          list.add(TextSpan(
              text: string,
          ));
          break;
        }else{
          String pStr_pre = string.substring(0,indexP);
          list.add(TextSpan(
              text: pStr_pre,
          ));
          String pStr = string.substring(indexP + 3,index_P);
          list.add(TextSpan(
              text: pStr,
              style: pTextStyle
          ));
          string = string.substring(index_P + 4);
        }
      }
    }
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: list,
      ),
    );
  }
}