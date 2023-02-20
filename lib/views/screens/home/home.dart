import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: GetBuilder<HomeController>(builder: (controller) =>controller.currentScreen,),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
      child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return AnimatedBottomNavigationBar.builder(
            backgroundColor: AppColors.primaryColor,
            itemCount: controller.screens.length,
            tabBuilder: (int index , bool isActive){
              return controller.tabBuilder(index, isActive);
            },
            activeIndex: controller.currentIndex,
            gapLocation: GapLocation.end,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (int index){
              print('onTap');
              controller.onTap(index);
            },
            //other params
          );
        },
      ),
    );
  }
}
