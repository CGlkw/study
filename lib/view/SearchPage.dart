
import 'package:flutter/material.dart';
import 'package:study/api/YouDaoApi.dart';
import 'package:study/view/detali/detail.dart';

const searchList = [
  'jiejie-大长腿',
  'jiejie-水蛇腰',
  'gege-帅气欧巴',
  'gege-小鲜肉'
];

const recentSuggest = [
  '推荐-1',
  '推荐-2',
];

class SearchPage extends SearchDelegate<String>{

  List searchResult = [];
  int queryLength = 0;
  String word = "";
  Widget resultWidget;
  var detail;
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

  Widget _oldWidget =  Container(child: Text("没有数据！"),);
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
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText( //富文本
                text: TextSpan(
                  text: data[index]["entry"],
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
              Text(data[index]["explain"],
                style: TextStyle(
                    color: Colors.grey,
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