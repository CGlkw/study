
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study/api/YouDaoApi.dart';
import 'package:study/config.dart';
import 'package:study/utils/SpUtils.dart';
import 'package:study/view/detali/detail.dart';

class SearchPage extends SearchDelegate<String>{

  List searchResult = [];
  int queryLength = 0;
  String word = "";
  Widget resultWidget;
  var detail;
  Widget _oldWidget = Container();

  SearchPage(){
    _buildHistroy().then((value) => _oldWidget = value);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ),
        onPressed: () => close(context, null)  //点击时关闭整个搜索页面
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(new Duration(milliseconds: 100)),
      builder: (BuildContext context, AsyncSnapshot s) {
        switch (s.connectionState) {
          case ConnectionState.done:
            if (s.hasError) {
              return Text('Error: ${s.error}');
            } else {
              return WordDetail(query);
            }
            break;
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _searchDate(),
      builder: (BuildContext context, AsyncSnapshot<List> s) {
        switch (s.connectionState) {
          case ConnectionState.waiting:
            return _oldWidget;
            break;
          case ConnectionState.done:
            if (s.hasError) {
              return Text('Error: ${s.error}');
            } else {
              return _buildResult(s.data);
            }
            break;
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildResult(data){
    if(data == null || data.length == 0){
      return _oldWidget;
    }
    _oldWidget = ListView.separated(
      itemCount:data.length,
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
            query = data[index]["entry"];
            //保存历史
            _saveHistroy(data[index]);
            showResults(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText( //富文本
                text: TextSpan(
                  text: data[index]["entry"],
                  style: TextStyle(color: ColorConfig.primary_text,fontWeight: FontWeight.bold),
                ),
              ),
              Text(data[index]["explain"],
                style: TextStyle(
                    color: ColorConfig.secondary_text,
                    height: 1.3,
                    letterSpacing: 1.1
                ),
              ),
            ],
          ),
        )
      ),
    );
    return _oldWidget;
  }

   Future<Widget> _buildHistroy() async {
    String s = await SpUtils.getStr("searchHistroy");
    if(s == null ){
      return Container();
    }
    List data = json.decode(s) as List;
    if(data == null || data.length < 0){
      return Container();
    }
    return ListView.separated(
      itemCount:data.length,
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
              query = data[index]["entry"];
              showResults(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText( //富文本
                  text: TextSpan(
                    text: data[index]["entry"],
                    style: TextStyle(color: ColorConfig.primary_text,fontWeight: FontWeight.bold),
                  ),
                ),
                Text(data[index]["explain"],
                  style: TextStyle(
                      color: ColorConfig.secondary_text,
                      height: 1.3,
                      letterSpacing: 1.1
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }


  _saveHistroy(Map j) async {
    String s = await SpUtils.getStr("searchHistroy");
    List list ;
    if(s == null){
      list = [];
    }else {
      list = json.decode(s) as List;
    }
    if(list.length > 15){
      list.removeLast();
    }
    list.insert(0, j);
    SpUtils.setStr("searchHistroy", json.encode(list));
  }

  Future<List> _searchDate() async {
    if(query == null || query == ""){
      return [];
    }
    Map value = await YouDaoApi().search(query);
    if(value["result"]["code"] == 200){
      queryLength = query.length;
      return value["data"]["entries"];
    }
  }


}