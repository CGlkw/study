
import 'package:flutter/material.dart';
import 'package:study/common/VolumeAnimation.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';
import 'package:study/view/SearchPage.dart';

class Index extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IndexState();

}

class _IndexState extends State<Index>{

  List<Word> words;

  @override
  void initState() {
    super.initState();
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
        child:ListView.separated(
          itemCount:words.length,
          separatorBuilder: (buildContext, index) {
            return Divider(
              height: 0.5,
              color: Colors.grey,
            );
          },
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context,index) => ListTile(
              title: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, "/word/detail", arguments: words[index].word);

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText( //富文本
                      text: TextSpan(
                        text: words[index].word,
                        style: TextStyle(color: ColorConfig.primary_text,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}