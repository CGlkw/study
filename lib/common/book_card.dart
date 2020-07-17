
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget{

  final String title;
  final MaterialColor color;
  final int count;
  final String word;

  BookCard({
    this.title = "我的单词本",
    this.count = 123,
    this.word = "A",
    this.color = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    Color color1 = color.shade700;
    Color color2 = color.shade400;
    List<Color> colors = [color1,color2];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child:LayoutBuilder(
        builder: (context,constraints){
          double parentW = constraints.biggest.width;
          double parentH = constraints.biggest.height;

          Gradient gradient = LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              color2,
              Colors.white30,
            ]
          );

          Shader shader = gradient.createShader(
            Rect.fromLTWH(0, 0, parentW, parentH / 2),
          );
          double w = parentW / 6;
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: colors,
                  ),
                ),
              ),

              Container(
                width: w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white30,
                      Color(0x00FFFFFF),
                      Color(0x00FFFFFF),
                      Colors.white30,
                      Color(0x00FFFFFF)
                    ]
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: parentW,
                      fontFamily: 'FuturaBlackBT_Regular',
                      foreground: Paint()..shader = shader,
                    ),
                  ),
                )
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(w),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: parentW / 7
                          ),
                        ),
                      )
                    ),
                    Container(
                      padding: EdgeInsets.all(w),
                      child: Text(
                        "$count 词",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: parentW / 10
                        ),
                      ),
                    )
                  ],
                )
              ),
            ],
          );
        }
      )
    );
  }

}