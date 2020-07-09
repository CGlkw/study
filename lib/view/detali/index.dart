
import 'package:flutter/material.dart';
import 'package:study/view/detali/detail.dart';

class DetailIndex extends StatelessWidget{

  var data;

  DetailIndex(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词详情"),
      ),
      body: WordDetail(data),
    );
  }

}