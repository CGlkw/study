
import 'package:flutter/material.dart';
import 'package:study/common/book_card.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Stack(
          children: <Widget>[
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(context),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.book),
                        title: const Text('单词本'),
                        onTap: () => Navigator.pushNamed(context, "/word/book"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.book),
                        title: const Text('card'),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookCard())),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
             right: 5,
             top: 5,
             child: IconButton(
              icon: Icon(Icons.favorite, color: Theme.of(context).primaryColor,),
              
              onPressed: () => Navigator.pushNamed(context, "maomi"),
            ) 
           ),
          ]
        )
      ),
    );
  }

   Widget _buildHeader(context) {
    return GestureDetector(
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(top: 40, bottom: 20),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipOval(
                // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                child: Image.asset(
                        "assets/imgs/default_avatar.png",
                        width: 80,
                      ),
              ),
            ),
            Text(
              'CG lkw',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
                    
          ],
        ),
      ),
    );
  }
}