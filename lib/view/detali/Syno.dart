
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class Syno extends StatelessWidget{

  var data;
  List synos;
  Syno(this.data);


  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }
    this.synos = data["synos"];
    List<InlineSpan> _buildSimilar(List data){
      if(data == null || data.length <=0){
        return [];
      }
      List<InlineSpan> res = [];
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data["pos"],
              style: TextStyle(
                  color: ColorConfig.primary_text,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child:Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(data["tran"],
                      style: TextStyle(
                          color: ColorConfig.primary_text,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: ColorConfig.secondary_text,
                        ),
                        children: _buildSimilar(data["ws"]),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      );
    }

    List<Widget> _buildChild(){
      List<Widget> res = [];
      for(int i = 0;i<(synos.length>3?3:synos.length);i++){
        res.add(_buildItem(synos[i], i));
      }
      return res;
    }

    return DetailItemCard(
      title: "同近义词",
      children: _buildChild(),
    );
  }

}
