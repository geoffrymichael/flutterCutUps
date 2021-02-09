import 'package:cut_ups/screens/editingScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  List<String> singleLines = [];

  final TextEditingController _controller = TextEditingController();
  String inputText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () async {
              if (inputText == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return EditingScreen(
                      fromCuttingScreen: singleLines,
                    );
                  }),
                );
              }
              if (singleLines.isEmpty) {
                singleLines = inputText.split('\n');
              } else {
                List<String> newTextData = inputText.split('\n');
                for (String line in newTextData) {
                  singleLines.add(line);
                }
              }
              _controller.clear();

              singleLines = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return EditingScreen(
                  fromCuttingScreen: singleLines,
                );
              }));
              print(singleLines);
            },
            child: Icon(Icons.cut_sharp),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: TextField(
            onChanged: (value) {
              inputText = value;
            },
            controller: _controller,
            enableInteractiveSelection: true,
            maxLines: 9999,
          ),
        ),
      ),
    );
  }
}
