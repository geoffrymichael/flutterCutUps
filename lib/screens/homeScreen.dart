import 'package:flutter/material.dart';
import 'package:cut_ups/screens/editingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> singleLines = [];

  final TextEditingController _controller = TextEditingController();

  String inputText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditingScreen(fromCuttingScreen: singleLines);
              }));
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onLongPress: () {
              print("long press");
            },
            onPressed: () {
              if (inputText == null || inputText.isEmpty) {
                print("null line");
              } else {
                if (singleLines.isEmpty) {
                  singleLines = inputText.split('\n');
                } else {
                  List<String> newTextData = inputText.split('\n');
                  for (String line in newTextData) {
                    singleLines.add(line);
                  }
                }
                _controller.clear();
                inputText = '';

                // singleLines = await Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return EditingScreen(
                //     fromCuttingScreen: singleLines,
                //   );
                // }));
                // print(singleLines);
              }
            },
            child: Icon(
              Icons.cut_sharp,
              color: Colors.black,
            ),
          ),
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
