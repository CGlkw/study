import 'package:flutter/material.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';

class BlngSentsPart extends StatefulWidget {
  var data;

  BlngSentsPart(this.data);
  @override
  State<StatefulWidget> createState() =>_BlngSentsPartState();
}

class _BlngSentsPartState extends State<BlngSentsPart>{


  @override
  Widget build(BuildContext context) {
    if(widget.data == null){
      return Container();
    }
    List sentence_pair =  widget.data["sentence-pair"] as List;


    List<Widget> _buildMore(){
      List<Widget> result = [];
      for(int i = 1;i< sentence_pair.length;i++){
        result.add(_buildItem(sentence_pair[i],EdgeInsets.only(left: 20,right: 55),),);
      }
      return result;
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 10),
            child: Text("双语",
              style: TextStyle(
                  color: ColorConfig.secondary_text,
                  fontSize: 10
              ),
            ),
          ),
          ExpansionTile(
            title: _buildItem(sentence_pair[0],EdgeInsets.only(left: 0,right: 0),),
            children: _buildMore(),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(data,EdgeInsetsGeometry padding){
    return Container(
      padding:padding,
      child: Row(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                ParsePLabel(
                    textStyle:TextStyle(
                        color: ColorConfig.primary_text,
                        fontSize: 12,
                        height: 1.5
                    ),
                    pTextStyle:TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        height: 1.5
                    )
                ).parse(data["sentence-eng"]),
                Text(
                  data["sentence-translation"],
                  style: TextStyle(
                      color: ColorConfig.primary_text,
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  data["source"],
                  style: TextStyle(
                      color: ColorConfig.placeholder_text,
                      fontSize: 8,
                      height: 1.5
                  ),
                ),
              ]
          ),
          Expanded(child: Text(" "),),
          WordAudioPlayer(
            "https://dict.youdao.com/dictvoice?audio="+data["sentence-speech"],
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}