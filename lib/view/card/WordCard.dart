

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';

class WordCard extends StatefulWidget{

  int index = 0;

  WordCard(this.index);

  @override
  State<StatefulWidget> createState() => _WordCardState();

}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {

  List<Word> words;
  PageController controller ;
  List<bool> isShowInterpretation = [];
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    controller = new PageController(
      viewportFraction: 0.9,
      initialPage: widget.index ?? 0,
    );
    WordDao().list().then((value) => {
      setState(() {
        words = value;
      })
    });
    words = []..add(Word.fromMap({
      'word':'word',
      'ukspeech':'test',
    'usspeech':'test',
    'ukphone':'test',
    'usphone':'test',

    'trans':'[{"pos":"e","tran":"sss"}]',
    }));
    animationController = AnimationController(
    vsync: this,
    duration: Duration(microseconds: 1000),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词学习"),
      ),
      body: words == null? Container():Container(
        decoration: BoxDecoration(
            color: ColorConfig.background_color_base
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: words.asMap().keys.map<Widget>((i){
                  List trans ;
                  if(words[i].trans != null){
                    trans = json.decode(words[i].trans) as List;
                  }
                  isShowInterpretation.add(false);
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
                                    words[i].word,
                                    style: TextStyle(
                                        color: ColorConfig.primary_text,
                                        fontWeight: FontWeight.bold,
                                      fontSize: 60
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    words[i].ukspeech==null?Container(): Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        )
                                      ),
                                      child: WordAudioPlayer(
                                        "https://dict.youdao.com/dictvoice?audio="+words[i].ukspeech,
                                        color:Theme.of(context).primaryColor,
                                        child: words[i].ukphone==null?Container():Text(
                                           "英/${ words[i].ukphone}/",
                                          style: TextStyle(
                                            color: ColorConfig.secondary_text
                                          ),
                                        ),
                                      ),
                                    ),
                                    words[i].usspeech==null?Container(): Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(
                                            color: Theme.of(context).primaryColor,
                                          )
                                      ),
                                      child: WordAudioPlayer(
                                        "https://dict.youdao.com/dictvoice?audio="+words[i].usspeech,
                                        color:Theme.of(context).primaryColor,
                                        child: words[i].usphone==null?Container():Text(
                                          "美/${ words[i].usphone}/",
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
                                  child: InkWell(
                                    onTap:() {
                                      setState(() {
                                        isShowInterpretation[i] = !isShowInterpretation[i];
                                      });
                                    },
                                    child:Center(
                                      child:isShowInterpretation[i] ? _buildInterpretation(trans):Center(
                                        child: Text("点击查看释义"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              child: Row(
                children: [
                  RaisedButton(
                    onPressed:(){

                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30), )
                    ),
                    child:Container(
                      height: 30,
                      padding: EdgeInsets.only(left: 10),
                      child:DropdownButton(
                        value: 1,

                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: 1,
                            child: Text("显示释义"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("隐藏释义"),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text("隐藏单词"),
                          ),
                        ],
                        onChanged: (v){

                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed:(){
                      animationController.forward();

                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30), )
                    ),
                    child:Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 10),
                      child: AnimatedIcon(
                        size: 30,
                        icon: AnimatedIcons.pause_play,
                        progress: animationController
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterpretation(trans){
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