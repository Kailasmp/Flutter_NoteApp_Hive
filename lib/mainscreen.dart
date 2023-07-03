import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_project_1/dialoguebox.dart';
import 'package:flutter_project_1/DetailScreen.dart';
import 'package:flutter/src/material/divider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _mybox = Hive.box('mybox');
  NoteAppDatabase db = NoteAppDatabase();
  @override
  void initState() {
    if (_mybox.get("NOTELIST") == null) {
      db.CreateInitalData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  List<String> notelistOnsearch = [];

  void CreateNote() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            controller: _controller,
            onSave: SaveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDatabase;
  }

  void SaveNewTask() {
    setState(() {
      db.notelist.add(_controller.text);
    });
    Navigator.of(context).pop();
    db.updateDatabase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  notelistOnsearch = db.notelist
                      .where((element) =>
                          element.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromARGB(255, 246, 238, 238)),
              ),
            )),
      ),
      body: ListView.builder(
          itemCount: _textEditingController.text.isNotEmpty
              ? notelistOnsearch.length
              : db.notelist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(19.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.add_a_photo),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const DetailScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      _textEditingController.text.isNotEmpty
                          ? notelistOnsearch[index]
                          : db.notelist[index],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton:
          // width: 50,
          // height: 50,
          FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        onPressed: CreateNote,
      ),
    );
  }
}
