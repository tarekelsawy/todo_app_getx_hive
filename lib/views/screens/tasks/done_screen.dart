import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/views/widgets/shared_widget.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.doneTasks.isNotEmpty
            ? ListView.builder(
                itemCount: controller.doneTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskItem(
                    task: controller.doneTasks[index],
                    index: index,
                    controller: controller,
                  );
                },
              )
            : Center(
                child: Text(
                  'No Done Tasks!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
      },
    );
  }
}
