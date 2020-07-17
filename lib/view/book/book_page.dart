

import 'package:flutter/material.dart';
import 'package:study/common/book_card.dart';
import 'package:study/dao/book_dao.dart';

class BookPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => _BookPageState();
  
}

class _BookPageState extends State<BookPage>{

  List<Book> books;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BookDao().list().then((value){
      setState(() {
        books = value;
      });
    });
    books = []..add(Book.fromMap({
      'name':'我的生词本',
      'count': 12,
      'color': 8,
      'word':"w",
      'isDefault':true,
    }))..add(Book.fromMap({
      'name':'考研词汇',
      'count': 1212,
      'color': 5,
      'word':"K",
      'isDefault':false,
    }));


  }

  @override
  Widget build(BuildContext context) {
    _buildItem(index){
      return Container(
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, "/word/book/detail",arguments: books[index].id),
          child: BookCard(
            title: books[index].name,
            count: books[index].count,
            color: books[index].color,
            word: books[index].word,
          )
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("生词本"),
      ),
      body: books == null? Container():Container(
        child:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.618 / 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(index);
          },
          itemCount: books.length,
        )
      ),
    );
  }
  
}