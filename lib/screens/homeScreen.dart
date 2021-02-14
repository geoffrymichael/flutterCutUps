import 'package:flutter/material.dart';
import 'package:cut_ups/screens/editingScreen.dart';

const Map howToSeparate = {
  1: 'Single Lines',
  3: 'Every 3rd Word',
  5: 'Every 5th Word',
  0: 'Single Words'
};

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> singleLines = [];

  final TextEditingController _controller = TextEditingController();

  String inputText;

  String whatIsGoingOn = 'blah blah blah';

  void printChangedValue(String dropDownValue) {
    setState(() {
      print('$dropDownValue sunday');
    });
  }

  void splitText(String dropDownValue) {
    if (dropDownValue == howToSeparate[1]) {
      print('singleLines');
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
      }
    } else {
      if (dropDownValue == howToSeparate[3]) {
        print('do something');
      }
    }
  }

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
          DropdownButton<String>(
            icon: Icon(
              Icons.map,
              color: Colors.black,
            ),
            items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              print(value);
            },
          ),
          CutDropDown(
            cutStyle: splitText,
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

class CutDropDown extends StatelessWidget {
  CutDropDown({this.cutStyle, this.dropDownValue});
  final Function cutStyle;
  final String dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(
        Icons.car_rental,
        color: Colors.black,
      ),
      items: <String>[
        howToSeparate[1],
        howToSeparate[3],
        howToSeparate[5],
        howToSeparate[0]
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: cutStyle,
    );
  }
}

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isChecked = false;
  void checkBoxCallback(bool checkBoxState) {
    //Why do we not need to provide checkBoxState argument when calling this in onChanged? Is it inferred
    setState(() {
      isChecked = checkBoxState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'This is a new task',
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckBox(
        checkboxState: isChecked,
        toggleCheckBoxState: checkBoxCallback,
      ),
    );
  }
}

class TaskCheckBox extends StatelessWidget {
  TaskCheckBox({this.checkboxState, this.toggleCheckBoxState});

  final bool checkboxState;
  final Function toggleCheckBoxState;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkboxState,
      onChanged:
          toggleCheckBoxState, //I have no idea, but I believe our bool argument is inferred from the on changed value.
    );
  }
}
