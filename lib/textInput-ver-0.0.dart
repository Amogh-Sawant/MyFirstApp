import 'package:flutter/material.dart';

class TxtIn extends StatefulWidget {
  @override
  _TxtInState createState() => _TxtInState();
}

class _TxtInState extends State<TxtIn> {
  TextEditingController text1 = new TextEditingController();
  String text2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: text1,
            obscureText: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Task',
            ),
          ),
          Text(text2 == null ? 'Nothing has been picked' : text2),
          FlatButton(
              onPressed: () {
                setState(() {
                  text2 = text1.text;
                  print(text2);
                });
              },
              child: Text("Add Task")),
        ],
      ),
    );
  }

  // void _sendTaskToSecondScreen(BuildContext context) {
  //   String textToSend = text1.text;
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SecondScreen(text: textToSend,),
  //       ));
  // }

}
