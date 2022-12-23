import 'package:flutter/material.dart';
import 'package:to_do_applications/Util/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final cotroller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({
    super.key,
    required this.cotroller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            //! Get UserInput
             TextField(
              controller: cotroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task"
              ),
            ),
            const SizedBox(height: 5,),

            //!Buttons For Save and Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //! Save Button
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                ),
                const SizedBox(width: 10,),
                //!Cancel Button
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}