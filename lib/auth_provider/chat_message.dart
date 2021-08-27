import 'package:flutter/material.dart';
class ChatMessage extends StatelessWidget {
  final int index;
  final Map<String,dynamic>data;



  const ChatMessage({Key key, this.index, this.data}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top:5,
              bottom:5,
              left: 10,
              right: 10
            ),
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            child: Text(data['value'],
              style: TextStyle(
              color:Colors.white,),

          )
          )
        ],
      ),
    );
  }
}
