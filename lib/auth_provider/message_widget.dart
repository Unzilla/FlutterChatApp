import 'package:flutter/material.dart';
class MessageForm extends StatefulWidget {
  final ValueChanged<String>onSubmit;

  const MessageForm({Key key, this.onSubmit}) : super(key: key);
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {

  String message;
  final msgController=TextEditingController();



  void onPressed() {

    widget.onSubmit(message);
    message="";
    msgController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                hintText: "type a message",
                filled: true,

                fillColor: Colors.white,
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),


                contentPadding: const EdgeInsets.all(10),


              ),
              minLines: 1,
              maxLines: 16,
              onChanged: (value){
                setState(() {
                  message=value;
                });

              },
            ),


          ),
          SizedBox(width: 5),
          RawMaterialButton(
            onPressed: (){
            message==null||message.isEmpty?null:onPressed();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)
            ),
            fillColor:message==null||message.isEmpty?
            Colors.blueGrey:
            Theme.of(context).primaryColor,
            child: Text('SEND',style: TextStyle(
              color:Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),),
          )
        ],
      )
    );
  }


}

