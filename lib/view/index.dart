
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study/common/VolumeAnimation.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';
import 'package:study/view/SearchPage.dart';

class Index extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IndexState();

}

class _IndexState extends State<Index>{

  List<Word> words;

  bool isShowInterpretation = true;

  @override
  void initState() {
    super.initState();
    _onRefresh();

  }

  Future<void> _onRefresh() async{
    WordDao().list().then((value) => {
      setState(() {
        words = value;
      })
    });
  }

  final GlobalKey<VolumeAnimationState> _cotroller = new GlobalKey<VolumeAnimationState>();
  bool b = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context,delegate: SearchPage());
            },
          )
        ],
      ),
      drawer: Container(),
      body: words == null? Container():Container(
        child:RefreshIndicator(
          onRefresh: _onRefresh,
          child:
          ListView.separated(
            itemCount:words.length,
            separatorBuilder: (buildContext, index) {
              return Divider(
                height: 0.5,
                color: Colors.grey,
              );
            },
            padding: EdgeInsets.all(8.0),
            itemBuilder: (context,index){
              var tran = json.decode(words[index].trans)[0];
              return Container(
                height: 80,
                width: double.infinity,
                child:Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: Center(
                        child:WordAudioPlayer(
                          "https://dict.youdao.com/dictvoice?audio="+words[index].ukspeech??words[index].usspeech??words[index].speech,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        onTap: () async {
                          //Navigator.pushNamed(context, "/word/detail", arguments: words[index].word);
                          Navigator.pushNamed(context, "/word/card",arguments:index);
                        },
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText( //富文本
                              text: TextSpan(
                                text: words[index].word,
                                style: TextStyle(
                                    color: ColorConfig.primary_text,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22
                                ),
                              ),
                            ),
                            isShowInterpretation?Text(
                              tran["pos"] + "  " + tran["tran"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ColorConfig.secondary_text,
                                  fontSize: 18
                              ),
                            ):Container(),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: ButtonBar(
        buttonPadding: EdgeInsets.all(3),
        children: [
          RaisedButton(
              onPressed:(){
                setState(() {
                  isShowInterpretation = !isShowInterpretation;
                });
              },
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
            ),
            child:Container(
              height: 50,
              padding: EdgeInsets.only(left: 10),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isShowInterpretation?Icons.visibility_off:Icons.visibility),
                  Text(isShowInterpretation?"隐藏释义":"显示释义",
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed:(){
              Navigator.pushNamed(context, "/word/card");
            },
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
            ),
            child:Container(
              height: 50,
              padding: EdgeInsets.only(right: 10),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.collections_bookmark),
                  Text("卡片学习",
                    style: TextStyle(
                      fontSize: 10
                    ),
                  ),
                ],
              ),
            ),

          ),
        ],
      ), /*FloatingActionButton.extended(
          onPressed: (){

          },
          icon: Icon(Icons.visibility_off),
          label: Text("隐藏释义")
      ),*/
    );
  }
}