import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_getx_hive/initial_bindings.dart';
import 'package:todo_getx_hive/views/routes/app_pages.dart';

import 'views/routes/app_routes.dart';

void main() {
  Hive.initFlutter();
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        initialRoute: Routes.home,
        initialBinding: InitialBindings(),
      );
    },);
  }

}