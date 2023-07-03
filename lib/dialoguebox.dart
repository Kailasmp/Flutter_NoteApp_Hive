import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogueBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Create New Notes',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  ElevatedButton(onPressed: onSave, child: Text('Save')),
                  const SizedBox(
                    width: 9,
                  ),
                  ElevatedButton(onPressed: onCancel, child: Text('Cancel')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
