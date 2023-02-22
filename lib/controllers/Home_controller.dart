import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx_hive/models/task.dart';
import 'package:todo_getx_hive/utils/constants.dart';
import 'package:todo_getx_hive/views/screens/tasks/archied_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/done_screen.dart';
import 'package:todo_getx_hive/views/screens/tasks/todo_screen.dart';
import 'package:uuid/uuid.dart';

import '../views/widgets/shared_widget.dart';

class HomeController extends GetxController {
  List<Task> tasks = [];
  List<Task> todoTasks = [];
  List<Task> doneTasks = [];
  List<Task> archivedTasks = [];
  late Box box;
  //text field
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController taskTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // tasks
  int currentIndex = 0;
  List<Widget> screens = [
    const ToDoScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];

  //Uuid
  late Uuid uuid;

  @override
  void onInit() {
    super.onInit();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(StatusAdapter());
    uuid = const Uuid();
    getAllTasks();
  }

  Future<void> openBox() async {
    try {
      box = Hive.box(AppConstants.tasksBoxName);
    } catch (e) {
      box = await Hive.openBox(AppConstants.tasksBoxName);
    }
  }

  void getAllTasks() async {
    await openBox();
    var tasks = box.get('tasks');
    if (tasks != null) {
      for (var task in tasks) {
        switch (task.taskStatus) {
          case Status.done:
            doneTasks.add(task);
            break;
          case Status.todo:
            todoTasks.add(task);
            break;
          case Status.archived:
            archivedTasks.add(task);
            break;
        }
      }
      this.tasks = todoTasks + archivedTasks + doneTasks;
    }
    update();
  }

  void addNewTask(Task newTask) async {
    tasks.add(newTask);
    box.put('tasks', tasks.toList());
    todoTasks.add(newTask);
    update();
  }

  void Function()? onNewTaskPressed() {
    if (formKey.currentState!.validate()) {
      addNewTask(
        Task(
          id: uuid.v1(),
          title: taskTitleController.text,
          time: taskTimeController.text,
          date: taskDateController.text,
          taskStatus: Status.todo,
        ),
      );

      Get.back();
    }
    return null;
  }

  void onDateFieldTap(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2125),
    );
    if (pickedDate != null) {
      debugPrint(pickedDate.toString());
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      taskDateController.text = formattedDate;
      debugPrint('formatedDate $formattedDate');
      update();
    }
  }

  void onTimeFieldTap(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (timeOfDay != null) {
      // ignore: use_build_context_synchronously
      taskTimeController.text = timeOfDay.format(context);
      update();
    }
  }

  //on navigation button click
  void onTap(int index) {
    currentIndex = index;
    update();
  }

  //On Archive Icon of Item Tap
  void onArchiveIconOfItemTap(int index, Status status) {
    switch (status) {
      case Status.done:
        onDoneScreenToArchive(index);
        break;
      case Status.todo:
        onToDoScreenToArchive(index);
        break;
      case Status.archived:
        onArchivedScreenToUnArchive(index);
        break;
    }
  }

  void onToDoScreenToArchive(int index) {
    Task task = todoTasks[index];
    task = task..taskStatus = Status.archived;
    archivedTasks.add(task);
    tasks.remove(todoTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    todoTasks.remove(todoTasks[index]);
    update();
  }

  void onDoneScreenToArchive(int index) {
    Task task = doneTasks[index];
    task = task..taskStatus = Status.archived;
    archivedTasks.add(task);
    tasks.remove(doneTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    doneTasks.remove(doneTasks[index]);
    update();
  }

  void onArchivedScreenToUnArchive(int index) {
    Task task = archivedTasks[index];
    task = task..taskStatus = Status.todo;
    todoTasks.add(task);
    tasks.remove(archivedTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    archivedTasks.remove(archivedTasks[index]);
    update();
  }

  //On Done Icon of Item Tap
  void onDoneIconOfItemTap(int index, Status status) {
    switch (status) {
      case Status.done:
        onDoneScreenToUnDone(index);
        break;
      case Status.todo:
        onToDoScreenToDone(index);
        break;
      case Status.archived:
        onArchivedScreenToDone(index);
        break;
    }
  }

  void onToDoScreenToDone(int index) {
    Task task = todoTasks[index];
    task = task..taskStatus = Status.done;
    doneTasks.add(task);
    tasks.remove(todoTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    todoTasks.remove(todoTasks[index]);
    update();
  }

  void onArchivedScreenToDone(int index) {
    Task task = archivedTasks[index];
    task = task..taskStatus = Status.done;
    doneTasks.add(task);
    tasks.remove(archivedTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    archivedTasks.remove(archivedTasks[index]);
    update();
  }

  void onDoneScreenToUnDone(int index) {
    Task task = doneTasks[index];
    task = task..taskStatus = Status.todo;
    todoTasks.add(task);
    tasks.remove(doneTasks[index]);
    tasks.add(task);
    box.put('tasks', tasks);
    doneTasks.remove(doneTasks[index]);
    update();
  }

  void onDismissible(int index, Status status) {
    switch (status) {
      case Status.done:
        onDoneDismiss(index);
        break;
      case Status.todo:
        onToDoDismiss(index);
        break;
      case Status.archived:
        onArchivedDismiss(index);
        break;
    }
  }

  void onDoneDismiss(int index) {
    tasks.remove(doneTasks[index]);
    box.put('tasks', tasks);
    doneTasks.remove(doneTasks[index]);
    update();
  }

  void onToDoDismiss(int index) {
    tasks.remove(todoTasks[index]);
    box.put('tasks', tasks);
    todoTasks.remove(todoTasks[index]);
    update();
  }

  void onArchivedDismiss(int index) {
    tasks.remove(archivedTasks[index]);
    box.put('tasks', tasks);
    archivedTasks.remove(archivedTasks[index]);
    update();
  }

  //tab builder
  Widget tabBuilder(int index, bool isActive) {
    return BottomNavigationBarTabBuildr(isActive: isActive, index: index);
  }

  Widget get currentScreen => screens[currentIndex];
}
