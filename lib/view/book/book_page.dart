

import 'package:flutter/material.dart';
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
    BookDao().list().then((value) => books = value);
  }

  @override
  Widget build(BuildContext context) {
    _buildItem(index){
      return Container(
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, "/word/book/detail",arguments: books[index].id),
          child: Center(
            child: Card(
              child: Text(books[index].name),
            ),
          ),
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
            crossAxisCount: 2,
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