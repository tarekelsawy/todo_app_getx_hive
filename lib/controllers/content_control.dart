
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_getx_hive/models/task.dart';
import 'package:todo_getx_hive/utils/constants.dart';
import 'package:todo_getx_hive/views/screens/tasks/archied_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/done_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/todo_screen.dart';

class HomeController extends GetxController{
  List<Task> todoTasks = [];
  List<Task> doneTasks = [];
  List<Task> archivedTasks = [];
  late Box box;

  // tasks
  int currentIndex=0;
  List<Widget> screens = [
    const ToDoScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];
  List<BubbleBottomBarItem> items = const [
    BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.dashboard, color: Colors.red,), title: Text("Home")),
    BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.access_time, color: Colors.black,), activeIcon: Icon(Icons.access_time, color: Colors.deepPurple,), title: Text("Logs")),
    BubbleBottomBarItem(backgroundColor: Colors.indigo, icon: Icon(Icons.folder_open, color: Colors.black,), activeIcon: Icon(Icons.folder_open, color: Colors.indigo,), title: Text("Folders")),
    BubbleBottomBarItem(backgroundColor: Colors.green, icon: Icon(Icons.menu, color: Colors.black,), activeIcon: Icon(Icons.menu, color: Colors.green,), title: Text("Menu"))
  ];

  @override
  void onInit(){
    super.onInit();
    // getAllTasks();
  }

  void getAllTasks() {
    openBox();
  }

  Future<void> openBox()  async {
    try{
      box =  Hive.box(AppConstants.tasksBoxName);
    }catch (e){
      box = await Hive.openBox(AppConstants.tasksBoxName);
    }
  }

  //on navigation button click
  void onTap(int index){
    currentIndex = index;
    update();
  }

  Widget get currentScreen => screens[currentIndex];
}