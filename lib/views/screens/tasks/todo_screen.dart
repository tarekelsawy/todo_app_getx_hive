import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/views/widgets/shared_widget.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.todoTasks.isNotEmpty
            ? ListView.builder(
                itemCount: controller.todoTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskItem(
                    task: controller.todoTasks[index],
                    index: index,
                    controller: controller,
                  );
                },
              )
            : Center(
                child: Text(
                  'Add New Task!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
      },
    );
  }
}
