
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';

class CardItem extends StatelessWidget{
  final int index;
  final Word data;
  final GlobalKey<WordAudioPlayerState> controller;
  bool isShowInterpretation;

  CardItem({
    this.index,
    this.data,
    this.controller,
    this.isShowInterpretation = false
  });

  @override
  Widget build(BuildContext context) {
    List trans ;
    if(data.trans != null){
      trans = json.decode(data.trans) as List;
    }
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 30,left: 5,right: 5),
      child:Column(
        children: [
          Expanded(
            child:Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 20,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50,bottom: 20),
                    child: Text(
                      data.word,
                      style: TextStyle(
                          color: ColorConfig.primary_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 60
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      data.ukspeech==null?Container(): Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.blueAccent,
                            )
                        ),
                        child: WordAudioPlayer(
                          "https://dict.youdao.com/dictvoice?audio="+data.ukspeech,
                          key: controller,
                          color:Colors.blueAccent,
                          child: data.ukphone==null?Container():Text(
                            "英/${ data.ukphone}/",
                            style: TextStyle(
                                color: ColorConfig.secondary_text
                            ),
                          ),
                        ),
                      ),
                      data.usspeech==null?Container(): Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.blueAccent,
                            )
                        ),
                        child: WordAudioPlayer(
                          "https://dict.youdao.com/dictvoice?audio="+data.usspeech,
                          color:Colors.blueAccent,
                          child: data.usphone==null?Container():Text(
                            "美/${ data.usphone}/",
                            style: TextStyle(
                                color: ColorConfig.secondary_text
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    indent:40,
                    endIndent: 40,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: _InterpretationPart(
                      trans: trans,
                      isShowInterpretation: isShowInterpretation,
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InterpretationPart extends StatefulWidget{
  final List trans;
  bool isShowInterpretation = false;
  _InterpretationPart({this.trans, this.isShowInterpretation});

  @override
  State<StatefulWidget> createState() => _InterpretationPartState();
}

class _InterpretationPartState extends State<_InterpretationPart>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        setState(() {
          widget.isShowInterpretation = !widget.isShowInterpretation;
        });
      },
      child:Center(
        child:widget.isShowInterpretation ? _InterpretationInfo(widget.trans):Center(
          child: Text("点击查看释义"),
        ),
      ),
    );
  }
}

class _InterpretationInfo extends StatelessWidget{
  final List trans;
  _InterpretationInfo(this.trans);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child:trans!= null?Table(
          columnWidths:{
            0: FixedColumnWidth(50.0),
          },
          children: trans.map<TableRow>((e) => TableRow(
              children: [
                Text(
                  e["pos"],
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: ColorConfig.regular_text,
                    fontSize: 20,
                    height: 1.5,
                    //letterSpacing: 1.2
                  ),
                ),
                Text(e["tran"],
                  style: TextStyle(
                    color: ColorConfig.regular_text,
                    fontSize: 20,
                    height: 1.5,
                    //letterSpacing: 1.2
                  ),
                ),
              ]
          )).toList(),
        ):Container()
    );

  }

}