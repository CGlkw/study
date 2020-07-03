
import 'package:flutter/material.dart';

class ClassicExample extends StatelessWidget{

  var data;

  var blng_sents_part;
  var auth_sents_part;
  var media_sents_part;
  ClassicExample(this.data)
      :blng_sents_part = data["blng_sents_part"],
        auth_sents_part = data["auth_sents_part"],
        media_sents_part = data["media_sents_part"];

  @override
  Widget build(BuildContext context) {
    if(blng_sents_part ==null && auth_sents_part==null &&media_sents_part==null){
      return Container();
    }
    return Container(
      child: Column(
        children: [
          Container(
            child:Text("经典例句",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70
              ),
            ),
          ),
          Container(
            child: Column(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }

}


class _BlngSentsPart extends StatelessWidget{

  var data;


  _BlngSentsPart(this.data);

  @override
  Widget build(BuildContext context) {
    return data == null ?Container() : Container(
      child: Column(
        children: [
          Container(
            child: Text("双语",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Column(

                )
              ],
            ),
          )
        ],
      ),
    );
  }

}