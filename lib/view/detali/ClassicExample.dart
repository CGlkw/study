
import 'package:flutter/material.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';

class ClassicExample extends StatelessWidget{

  var data;

  var blng_sents_part;
  var auth_sents_part;
  var media_sents_part;
  ClassicExample(this.data)
      :blng_sents_part = data["blng_sents_part"],
        auth_sents_part = data["auth_sents_part"],
        media_sents_part = data["media_sents_part"];

  @override
  Widget build(BuildContext context) {
    if(blng_sents_part ==null && auth_sents_part==null &&media_sents_part==null){
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: ColorConfig.background_color_base
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child:Text("经典例句",
              style: TextStyle(
                  fontSize: 10,
                  color: ColorConfig.placeholder_text
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                blng_sents_part != null ? BlngSentsPart(blng_sents_part):Container(),
                auth_sents_part != null ? AuthSentsPart(auth_sents_part):Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

}
