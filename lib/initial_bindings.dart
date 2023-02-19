import 'package:get/get.dart';
import 'package:todo_getx_hive/controllers/content_control.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}