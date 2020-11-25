import 'package:flutter/material.dart';

class TxtIn extends StatefulWidget {
  final String actualTask;
  TxtIn({this.actualTask});
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
        title: Text("Add Task"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: TextField(
                controller: text1,
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Task',
                  hintText: 'for eg: Water the plants',
                  isDense: true,
                ),
              ),
            ),
          ),
          // Text(text2 == null ? '' : text2),
          RaisedButton(
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  text2 = text1.text;

                  Navigator.of(context).pop(text2);
                  // print(text2);
                });

                // Navigator.of(context)
                //     .pushReplacement(MaterialPageRoute(builder: (context) {
                //   return MyHomePage(actualTask: text2);
                // }));
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              )),
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
