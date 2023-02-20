import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_getx_hive/models/task.dart';
import 'package:todo_getx_hive/utils/constants.dart';
import 'package:todo_getx_hive/views/screens/tasks/archied_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/done_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/todo_screen.dart';

import '../views/widgets/shared_widget.dart';

class HomeController extends GetxController {
  List<Task> todoTasks = [];
  List<Task> doneTasks = [];
  List<Task> archivedTasks = [];
  late Box box;

  // tasks
  int currentIndex = 0;
  List<Widget> screens = [
    const ToDoScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];





  @override
  void onInit() {
    super.onInit();
    // getAllTasks();
  }

  void getAllTasks() {
    openBox();
  }

  Future<void> openBox() async {
    try {
      box = Hive.box(AppConstants.tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(AppConstants.tasksBoxName);
    }
  }

  //on navigation button click
  void onTap(int index) {
    currentIndex = index;
    update();
  }

  //tab builder
  Widget tabBuilder(int index , bool isActive){
    return BottomNavigationBarTabBuildr(isActive: isActive,index: index);
  }
  Widget get currentScreen => screens[currentIndex];
}
