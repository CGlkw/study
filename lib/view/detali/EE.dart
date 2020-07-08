
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class EE extends StatelessWidget{

  var data;
  List trs;
  EE(this.data);


  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }
    this.trs = data["word"]["trs"] as List;

    List<InlineSpan> _buildSimilar(List data){
      if(data == null || data.length <=0){
        return [];
      }
      List<InlineSpan> res = [];
      res.add(TextSpan(
          text: "同义词："
      ));
      for(int i = 0;i<data.length;i++){
        res.add(TextSpan(
            text: data[i],
            style: TextStyle(
                color: ColorConfig.link
            ),
            recognizer: TapGestureRecognizer()..onTap = (){
              Navigator.pushNamed(context, "/word/detail", arguments: data[i]);
            }
        ),
        );
        if(i != data.length-1){
          res.add(TextSpan(
              text: " / "
          ));
        }

      }
      return res;
    }

    Widget _buildItem(data,index){
      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(data["pos"],
              style: TextStyle(
                  color: ColorConfig.primary_text,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5,bottom: 3),
              child: Text("${index + 1}. ${data["tr"][0]["tran"]}" ,
                style: TextStyle(
                    color: ColorConfig.primary_text,
                    fontSize: 14
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  data["tr"][0]["examples"] == null?Container(): Container(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: data["tr"][0]["examples"].map<Widget>((e) =>Text(
                         e,
                         style: TextStyle(
                             color: ColorConfig.secondary_text
                         ),
                       ),).toList(),
                    ),

                  ),
                  data["tr"][0]["similar-words"] == null ?Container(): Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: ColorConfig.secondary_text
                          ),
                          children: _buildSimilar(data["tr"][0]["similar-words"]),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> _buildChild(){
      List<Widget> res = [];
      for(int i = 0;i<(trs.length > 3?3:trs.length);i++){
        res.add(_buildItem(trs[i], i));
      }
      return res;
    }


    return DetailItemCard(
      title: "英英释义",
      children: _buildChild(),
    );

  }


}
