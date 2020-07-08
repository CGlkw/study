
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:study/api/YouDaoApi.dart';
import 'package:study/common/VolumeAnimation.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/view/detali/Etym.dart';
import 'package:study/view/detali/Phrs.dart';
import 'package:study/view/detali/Syno.dart';
import 'package:study/view/detali/WebTrans.dart';
import 'package:study/view/detali/WikipediaDigest.dart';

import 'ClassicExample.dart';
import 'DetailCart.dart';
import 'EE.dart';

// ignore: must_be_immutable
class WordDetail extends StatefulWidget{

  var word;

  WordDetail(this.word);

  @override
  State<StatefulWidget> createState() => _WordDetail();

}

class _WordDetail extends State<WordDetail> {

  Map detail;
  bool b = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.word:${widget.word}");
    YouDaoApi().detail(widget.word).then((value) => {
        if(mounted){
      setState((){
        detail = value;
      })
    }

    });
  }

  @override
  Widget build(BuildContext context) {
    return detail!=null?Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorConfig.background_color_base
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.background_color_white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(widget.word,
                        style: TextStyle(
                            fontSize: 40,
                            color: ColorConfig.primary_text,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      WordAudioPlayer(
                        "https://dict.youdao.com/dictvoice?audio="+detail["simple"]["word"][0]["ukspeech"],
                        color: Theme.of(context).primaryColor,
                        child: Text(" 英 /${detail["simple"]["word"][0]["ukphone"]??''}/",
                          style: TextStyle(
                            color: ColorConfig.primary_text
                          ),
                        ),
                      ),
                      WordAudioPlayer(
                        "https://dict.youdao.com/dictvoice?audio="+detail["simple"]["word"][0]["usspeech"],
                        color: Theme.of(context).primaryColor,
                        child: Text(" 美 /${detail["simple"]["word"][0]["usphone"]??''}/",
                          style: TextStyle(
                              color: ColorConfig.primary_text
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(

                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      DetailCard(detail["ec"]),
                      ClassicExample(detail),
                      WebTrans(detail["web_trans"]),
                      EE(detail["ee"]),
                      Syno(detail["syno"]),
                      Phrs(detail["phrs"]),
                      Etym(detail["etym"]),
                      WikipediaDigest(detail["wikipedia_digest"]??detail["baike"]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
    ):Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

}