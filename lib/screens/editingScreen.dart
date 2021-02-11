import 'package:flutter/material.dart';

class EditingScreen extends StatefulWidget {
  EditingScreen({this.fromCuttingScreen});
  List<String> fromCuttingScreen;

  @override
  _EditingScreenState createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  List<String> sampleList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, widget.fromCuttingScreen);
            print("back buttonn pressed");
          },
        ),
        actions: [],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          print("did I pop?");
          return false;
        },
        child: SafeArea(
          child: ReorderableListView(
            children: [
              for (final item in widget.fromCuttingScreen)
                Card(
                  key: ValueKey(item),
                  elevation: 2,
                  child: ListTile(
                    title: Text(item),
                  ),
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = widget.fromCuttingScreen.removeAt(oldIndex);
                widget.fromCuttingScreen.insert(newIndex, item);
              });
            },
          ),
        ),
      ),
    );
  }
}
