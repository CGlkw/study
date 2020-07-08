
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class Phrs extends StatelessWidget{

  var data;
  var phrs;
  Phrs(this.data);

  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }
    this.phrs = data["phrs"];
    Widget _buildItem(data,index){
      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${index +1}. ",
              style: TextStyle(
                  color: ColorConfig.primary_text,
              ),
            ),
            Expanded(
                child:Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "/word/detail", arguments: data["headword"]);
                        },
                        child:Text(data["headword"],
                          style: TextStyle(
                            color: ColorConfig.link,
                          ),
                        ),
                      ),

                      Text(data["translation"],
                        style: TextStyle(
                          color: ColorConfig.primary_text,
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
      for(int i = 0;i<(phrs.length>3?3:phrs.length);i++){
        res.add(_buildItem(phrs[i], i));
      }
      return res;
    }

    return DetailItemCard(
      title: "词组短语",
      children: _buildChild(),
    );
  }

}
