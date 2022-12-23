import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List toDoList = [];
  //Reference our box
  final _myBox = Hive.box("mybox");

  //Run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Make a food', false],
      ['Explore the world!', true],
    ];
  }

  //Load the data from DB
  void load() {
    toDoList = _myBox.get('TODOLIST');
  }

  //Update the data from DB

  void updateDatabasr() {
    _myBox.put('TODOLIST', toDoList); 
  }
}