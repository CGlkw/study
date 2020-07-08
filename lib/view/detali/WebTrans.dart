
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class WebTrans extends StatelessWidget{

  var data;
  List web_translation;
  List trans;
  WebTrans(this.data);


  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }
    this.web_translation = data["web-translation"] as List;
    this.trans = data["web-translation"][0]["trans"] as List;
    List<Widget> _buildChild(){
      List<Widget> result = [];
      for (int i = 0;i< (trans.length<3? trans.length: 3); i++){
        result.add(_buildItem(context, trans[i], i));
      }
      return result;
    }

    return DetailItemCard(
      title: "网络释义",
      children: _buildChild(),
    );
  }

  Widget _buildItem(BuildContext context,data,index){
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 3),
            child: Text("${index + 1}、${data["value"]}" ,
              style: TextStyle(
                  color: ColorConfig.secondary_text,
                  fontSize: 12
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10,left: 10),
            child: ParsePLabel(
                textStyle:TextStyle(
                    color: ColorConfig.primary_text,
                    fontSize: 14,
                    height: 1.5
                ),
                pTextStyle:TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    height: 1.5
                )
            ).parse(data["summary"]["line"][0]),
          ),
        ],
      ),
    );

  }

}
