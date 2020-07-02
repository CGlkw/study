
import 'package:flutter/material.dart';
import 'package:study/common/VolumeAnimation.dart';
import 'package:study/view/SearchPage.dart';

class Index extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IndexState();

}

class _IndexState extends State<Index>{

  final GlobalKey<VolumeAnimationState> _cotroller = new GlobalKey<VolumeAnimationState>();
  bool b = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBarDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context,delegate: SearchPage());
            },
          )
        ],
      ),
      body: Container(
        child: InkWell(
          onTap: (){
            if (b) {
              _cotroller.currentState.stopAnimation();
            } else {
              _cotroller.currentState.startAnimation();
            }

            b = !b;
          },
          child: VolumeAnimation(_cotroller,size: 50,start: false,),
        ),
      ),
    );
  }
}