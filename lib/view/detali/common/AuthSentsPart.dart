
import 'package:flutter/material.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';

class AuthSentsPart extends StatefulWidget {

  var data;

  AuthSentsPart(this.data);
  @override
  State<StatefulWidget> createState() =>_AuthSentsPartState();

}

class _AuthSentsPartState extends State<AuthSentsPart>{
  @override
  Widget build(BuildContext context) {
    if(widget.data == null){
      return Container();
    }
    List sent =  widget.data["sent"] as List;


    List<Widget> _buildMore(){
      List<Widget> result = [];
      for(int i = 1;i< sent.length;i++){
        result.add(_buildItem(sent[i],EdgeInsets.only(left: 20,right: 55),),);
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
            padding: EdgeInsets.only(top: 5,bottom: 3),
            child: Text("权威",
              style: TextStyle(
                  color: ColorConfig.secondary_text,
                  fontSize: 12
              ),
            ),
          ),
          ExpansionTile(
            title: _buildItem(sent[0],EdgeInsets.only(left: 0,right: 0),),
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
          Expanded(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Container(
                    padding: EdgeInsets.only(right: 5),
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
                    ).parse(data["foreign"]),
                  ),

                  Text(
                    (data["source"] as String ).replaceAll("<i>", "").replaceAll("</i>", ""),
                    style: TextStyle(
                        color: ColorConfig.placeholder_text,
                        fontSize: 10,
                        height: 1.5
                    ),
                  ),
                ]
            ),
          ),
          WordAudioPlayer(
            "https://dict.youdao.com/dictvoice?audio="+data["speech"],
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}