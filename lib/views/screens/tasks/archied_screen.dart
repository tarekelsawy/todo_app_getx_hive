import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/views/widgets/shared_widget.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.archivedTasks.isNotEmpty
            ? ListView.builder(
                itemCount: controller.archivedTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskItem(
                    task: controller.archivedTasks[index],
                    index: index,
                    controller: controller,
                  );
                },
              )
            : Center(
                child: Text(
                  'No Archived Tasks!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
      },
    );
  }
}
