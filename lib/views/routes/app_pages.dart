import 'package:get/get.dart';
import 'package:todo_getx_hive/views/screens/home/home.dart';

import 'app_routes.dart';

class AppPages{
  static final pages = [
    GetPage(name: Routes.home, page: ()=>const HomeScreen()),
  ];
}