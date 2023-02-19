import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_hive/controllers/content_control.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: controller.currentScreen,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: controller.currentIndex,
        onTap: (int? index) {
          controller.onTap(index ?? 0);
        },
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: controller.items,
      ),
    );
  }
}
