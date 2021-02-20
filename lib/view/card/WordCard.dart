

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:study/common/WordAudioPlayer.dart';
import 'package:study/config.dart';
import 'package:study/dao/word_dao.dart';
import 'package:study/view/card/card_item.dart';

class WordCard extends StatefulWidget{

  int index = 0;

  WordCard(this.index);

  @override
  State<StatefulWidget> createState() => _WordCardState();

}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {

  List<Word> words;
  PageController controller ;
  Map<int,bool> isShowInterpretation = {};
  Map<int, GlobalKey<WordAudioPlayerState>> audioPlayerControllerMap = {};
  AnimationController animationController;
  bool isAutoNext = false;
  bool isOrder = true;
  bool isAutoPlay = false;
  int length = 0;
  int _curIndex;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    try{
      WordDao().list().then((value) => {
        setState(() {
          words = value;
          length = words.length;
        })
    });
    }catch(e){

    }

    length = words.length;

    _curIndex = (widget.index ?? 0) + length * 2;
    controller = new PageController(
      viewportFraction: 0.9,
      initialPage: _curIndex,
    );
    if(isAutoNext){
      _initTimer();
    }

    animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this
    );

  }
  /// 切换页面，并刷新小圆点
  _changePage() {
    Timer(Duration(milliseconds: 350), () {
      controller.jumpToPage(_curIndex);
    });
  }
  /// 初始化定时任务
  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 3), (t) {
        _curIndex++;
        controller.animateToPage(
          _curIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      });
    }
  }
  /// 点击到图片的时候取消定时任务
  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      //_initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词学习"),
      ),
      body: words == null ? Container():Container(
        decoration: BoxDecoration(
            color: ColorConfig.background_color_base
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged:(index){
                  setState(() {
                    _curIndex = index;
                    if (index == 0) {
                      _curIndex = length;
                      _changePage();
                    }
                  });
                  if(isAutoPlay){
                    audioPlayerControllerMap[index].currentState.playAudio();
                  }
                },
                itemBuilder: (c, i){
                  return _buildItem(c,words[i % length],i);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: RaisedButton(
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
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: RaisedButton(
                      onPressed:(){
                        isAutoNext = !isAutoNext;
                        isAutoNext?animationController.forward():animationController.reverse();
                        if(isAutoNext){
                          _timer = _initTimer();
                          showToast("自动翻页");
                        }else{
                          _cancelTimer();
                          showToast("关闭自动翻页");

                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30), )
                      ),
                      child:Container(
                        height: 50,
                        child:Center(
                          child:AnimatedIcon(
                              size: 40,
                              icon: AnimatedIcons.play_pause,
                              progress: animationController
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset:Offset(3.0,3.0),
                                blurRadius: 5
                              ),
                            ]
                          ),
                          child: AnimatedSwitcher(
                            transitionBuilder: (child, anim){
                              return ScaleTransition(child: child,scale: anim);
                            },
                            duration: Duration(milliseconds: 300),
                            child: IconButton(
                              key: ValueKey(isOrder?Icons.repeat:Icons.shuffle),
                              icon: Icon(isOrder?Icons.repeat:Icons.shuffle,size: 20,),
                              onPressed: () {
                                setState(() {
                                  isOrder = !isOrder;
                                });
                                isOrder? showToast("顺序模式"):showToast("乱序模式");
                              }
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset:Offset(3.0,3.0),
                                    blurRadius: 5
                                ),
                              ]
                          ),
                          child: AnimatedSwitcher(
                            transitionBuilder: (child, anim){
                              return ScaleTransition(child: child,scale: anim);
                            },
                            duration: Duration(milliseconds: 300),
                            child: IconButton(
                                key: ValueKey(isAutoPlay?Icons.volume_up:Icons.volume_off),
                                icon: Icon(isAutoPlay?Icons.volume_up:Icons.volume_off),
                                onPressed: () {
                                  setState(() {
                                    isAutoPlay = !isAutoPlay;
                                  });
                                  isAutoPlay? showToast("自动播放声音"):showToast("关闭");

                                }),
                          ),
                        ),

                      ],
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

  Widget _buildItem(context, Word data, index){
    final GlobalKey<WordAudioPlayerState> _controller = new GlobalKey<WordAudioPlayerState>();
    audioPlayerControllerMap.putIfAbsent(index, () => _controller);
    return CardItem(
      isShowInterpretation: false,
      controller: _controller,
      data: data,
      index: index,
    );
  }

}