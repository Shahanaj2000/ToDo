import 'package:flutter/material.dart';
import '../Util/dailog_box.dart';
import '../Util/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //! Text Controller
  final _controller = TextEditingController();
  //! List Of ToDo Tasks
  List toDoList = [
    ['Make Totorials', true],
    ['Do Somework', false],
  ];

  //! checkBox Was Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
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
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //! Delete Task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
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
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
                taskName: toDoList[index][0],
                taskCompleted: toDoList[index][1],
                
                onChanged: (value) {
                  checkBoxChanged(value, index);
                },

                deleteFunction: (p0) => deleteTask(index),
                
              );
          },
        ));
  }
}
