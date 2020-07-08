
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class Etym extends StatelessWidget{

  var data;
  List zh;
  List en;
  Etym(this.data);


  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }
    this.zh = data["etyms"]["zh"];
    this.en = data["etyms"]["en"];
    Widget _buildItem(data,index){
      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: data["word"],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    )
                  ),
                  TextSpan(
                    text: " : ${data["desc"]}",
                    style: TextStyle(
                        color: ColorConfig.primary_text
                    )
                  ),
                ]
              ),
            ),

            Text(data["value"],
              style: TextStyle(
                color: ColorConfig.secondary_text,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> _buildChild(){
      List<Widget> res = [];
      if(zh != null){
        for(int i = 0;i<(zh.length>3?3:zh.length);i++){
          res.add(_buildItem(zh[i], i));
        }
      }
      if(en != null){
        for(int i = 0;i<(en.length>3?3:en.length);i++){
          res.add(_buildItem(en[i], i));
        }
      }

      return res;
    }

    return DetailItemCard(
      title: "词源",
      children: _buildChild(),
    );
  }

}
