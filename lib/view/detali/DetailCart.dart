
import 'package:flutter/material.dart';
import 'package:study/config.dart';

class DetailCard extends StatelessWidget{

  final Map data;
  var wordTrs;

  DetailCard(this.data)
      :wordTrs = data["word"]["trs"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.background_color_base,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child:Table(
              columnWidths:{
                0: FixedColumnWidth(50.0),
              },
              children: wordTrs.map<TableRow>((e) => TableRow(
                  children: [
                    Text(
                      e["pos"],
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                          //letterSpacing: 1.2
                      ),
                    ),
                    Text(e["tran"],
                      style: TextStyle(
                          height: 1.5,
                          //letterSpacing: 1.2
                      ),
                    ),
                  ]
              )).toList(),
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  height: 2,
                  letterSpacing: 1.2
              ),
              children: [
                TextSpan(
                  text: "[网络]",
                  style: TextStyle(
                    color:  ColorConfig.secondary_text
                  )
                ),
                TextSpan(
                  text: "\t"
                ),
                TextSpan(
                  text: data["web_trans"].join('；'),
                  style:TextStyle(
                      color:  ColorConfig.regular_text
                  )
                )
              ]
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  height: 2,
                  letterSpacing: 1.2
              ),
              children: [
                TextSpan(
                  text: data["exam_type"].join('；'),
                  style: TextStyle(
                    color: ColorConfig.placeholder_text
                  )
                )
              ]
            ),
          )
        ],
      ),
    );
  }

}