
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:study/api/YouDaoApi.dart';
import 'package:study/common/VolumeAnimation.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';
import 'package:study/utils/TimeUtils.dart';
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
  bool isExits = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    YouDaoApi().detail(widget.word).then((value) => {
      if(mounted){
        setState((){
          detail = value;
        })
      }
    });

    WordDao().select(widget.word).then((value) =>{
      if (value == null){
          isExits = false
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(detail==null){
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
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
                  detail["simple"]==null?Container():Row(
                    children: [
                      detail["simple"]["word"][0]["ukspeech"]==null ?Container(): WordAudioPlayer(
                        "https://dict.youdao.com/dictvoice?audio="+detail["simple"]["word"][0]["ukspeech"],
                        color: Theme.of(context).primaryColor,
                        child: detail["simple"]["word"][0]["ukphone"]==null|| detail["simple"]["word"][0]["ukphone"] =="" ?null:Text(" 英 /${detail["simple"]["word"][0]["ukphone"]}/",
                          style: TextStyle(
                            color: ColorConfig.primary_text
                          ),
                        ),
                      ),
                      detail["simple"]["word"][0]["usspeech"] == null ? Container():WordAudioPlayer(
                        "https://dict.youdao.com/dictvoice?audio="+detail["simple"]["word"][0]["usspeech"],
                        color: Theme.of(context).primaryColor,
                        child: detail["simple"]["word"][0]["usphone"] == null || detail["simple"]["word"][0]["usphone"] =="" ? null:Text(" 美 /${detail["simple"]["word"][0]["usphone"]}/",
                          style: TextStyle(
                              color: ColorConfig.primary_text
                          ),
                        ),
                      ),
                      detail["simple"]["word"][0]["speech"] == null ? Container():WordAudioPlayer(
                        "https://dict.youdao.com/dictvoice?audio="+detail["simple"]["word"][0]["speech"],
                        color: Theme.of(context).primaryColor,
                        child: detail["simple"]["word"][0]["phone"] == null || detail["simple"]["word"][0]["phone"] =="" ? null:Text("/${detail["simple"]["word"][0]["phone"]}/",
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
      floatingActionButton:isExits?null: FloatingActionButton(
        onPressed: (){
          Word word = Word();
          word.word = widget.word;
          word.detail = json.encode(detail) ;
          word.core = 0;
          word.createTime = TimeUtils.currentTimeMillis();
          WordDao().insert(word).then((value) => showToast("添加成功"));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}