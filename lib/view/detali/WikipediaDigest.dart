
import 'package:flutter/material.dart';
import 'package:study/common/DetailItemCard.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/utils/ParsePLabel.dart';
import 'package:study/view/detali/common/AuthSentsPart.dart';
import 'package:study/view/detali/common/BlngSentsPart.dart';
import 'package:study/view/detali/common/MediaSentsPart.dart';

class WikipediaDigest extends StatelessWidget{

  var data;

  WikipediaDigest(this.data);

  @override
  Widget build(BuildContext context) {
    if(data ==null){
      return Container();
    }

    List<Widget> _buildChild(){
      List<Widget> res = []..add(
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child:Text(
                    data["summarys"][0]["key"],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),

                Text(data["summarys"][0]["summary"],
                  style: TextStyle(
                    color: ColorConfig.secondary_text,
                    fontSize: 12
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: ColorConfig.secondary_text,
                      fontSize: 10
                    ),
                    children: [
                      TextSpan(
                        text: "以上来源于 - "
                      ),
                      TextSpan(
                        text: data["source"]["name"],
                        style: TextStyle(
                          color: ColorConfig.link
                        )
                      )
                    ]
                  ),
                ),

              ],
            ),
          ),
      );

      return res;
    }

    return DetailItemCard(
      title: "百科",
      children: _buildChild(),
    );
  }

}
