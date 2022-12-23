import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_applications/db/database.dart';
import '../Util/dailog_box.dart';
import '../Util/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //! Reference the Hive
  final _myBox = Hive.box("mybox");

  //! Text Controller
  final _controller = TextEditingController();
  //! Cretate Instances or object for the ToDoDataBase (database.dart file)
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // TODO if this is the 1st time ever opening the app, then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //TODO There already exists the data
      db.load();
    }
    super.initState();
  }
  

  //! checkBox Was Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabasr();
  }



  //! create New Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (builder) {
        return  DialogBox(
          cotroller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();

          },
        );
      }
    );
  }

  //! saveNewTask
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabasr();
  }

  //! Delete Task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabasr();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('T O D O'),
          centerTitle: true,
          elevation: 0,
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                
                onChanged: (value) {
                  checkBoxChanged(value, index);
                },

                deleteFunction: (p0) => deleteTask(index),
                
              );
          },
        ));
  }
}
