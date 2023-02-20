import 'package:flutter/material.dart';
import 'package:todo_getx_hive/views/widgets/shared_widget.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return const TaskItem();
      },
    );
  }
}
