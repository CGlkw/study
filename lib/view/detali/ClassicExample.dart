
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class ClassicExample extends StatelessWidget{

  var data;

  var blng_sents_part;
  var auth_sents_part;
  var media_sents_part;
  ClassicExample(this.data);

  @override
  Widget build(BuildContext context) {
    if(data == null){
      return Container();
    }
    blng_sents_part = data["blng_sents_part"];
    auth_sents_part = data["auth_sents_part"];
    media_sents_part = data["media_sents_part"];
    if(blng_sents_part ==null && auth_sents_part==null &&media_sents_part==null){
      return Container();
    }
    return DetailItemCard(
      title: "经典例句",
      children: [
        blng_sents_part != null ? BlngSentsPart(blng_sents_part):Container(),
        auth_sents_part != null ? AuthSentsPart(auth_sents_part):Container(),
        media_sents_part != null ? MediaSentsPart(media_sents_part):Container(),
      ],
    );
  }

}
