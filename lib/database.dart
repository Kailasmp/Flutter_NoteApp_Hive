import 'package:hive_flutter/hive_flutter.dart';

class NoteAppDatabase {
  List<String> notelist = [];
  final _mybox = Hive.box('mybox');
  void CreateInitalData() {
    List<String> notelist = [
      "Daily routine",
      "Personal",
      "Journal",
      "Great Day",
    ];
  }

  void loadData() {
    notelist = _mybox.get("NOTELIST");
  }

  void updateDatabase() {
    _mybox.put("NOTELIST", notelist);
  }
}
