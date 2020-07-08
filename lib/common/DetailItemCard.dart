
import 'package:flutter/material.dart';
import 'package:study/config.dart';

class DetailItemCard extends StatelessWidget{

  final String title;
  final List<Widget> children;
  final GestureTapCallback doMore;


  DetailItemCard({
    @required this.title,
    @required this.children,
    this.doMore
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10,bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConfig.background_color_white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child:Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: ColorConfig.placeholder_text
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          )
        ],
      ),
    );
  }

}