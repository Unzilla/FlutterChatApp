import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ChatMessageOther extends StatelessWidget {
  final int index;


  final Map<String,dynamic>data;
  final bool showAvatar;

  const ChatMessageOther({Key key, this.index, this.data,this.showAvatar=true}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6
      ),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(showAvatar)
            CircleAvatar(
              backgroundImage: NetworkImage(
                data['photo_url']),


            )
          else
            SizedBox(width: 10,)
    ,
    SizedBox(width:10),
    Container(
      padding: const EdgeInsets.all(16),

      constraints:BoxConstraints(
    maxWidth: 300,
    ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          Text('${data['author']} said:',style: TextStyle(
            color: Colors.blueGrey,
            fontStyle: FontStyle.italic,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5),
          Text(data['value']),

        ],
      )
          )
        ],
      ),
    );
  }
}