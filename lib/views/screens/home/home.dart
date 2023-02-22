import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/utils/colors.dart';
import 'package:todo_getx_hive/views/widgets/shared_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => controller.currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp),
            ),
            builder: (context) {
              return WritingNewTaskWidget(
                controller: controller,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return AnimatedBottomNavigationBar.builder(
            backgroundColor: AppColors.primaryColor,
            itemCount: controller.screens.length,
            tabBuilder: (int index, bool isActive) {
              return controller.tabBuilder(index, isActive);
            },
            activeIndex: controller.currentIndex,
            gapLocation: GapLocation.end,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (int index) {
              controller.onTap(index);
            },
            //other params
          );
        },
      ),
    );
  }
}

class WritingNewTaskWidget extends StatelessWidget {
  final HomeController controller;
  const WritingNewTaskWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 3.w, vertical: 1.5.h),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_task_sharp,
                    size: 30.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'New Task',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 6.w,
              ),
              CustomTextFormField(
                controller: controller.taskTitleController,
                textInputType: TextInputType.text,
                hintText: 'type task title',
                labelText: 'task title',
                onChanged: (String value) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                controller: controller.taskDateController,
                textInputType: TextInputType.datetime,
                hintText: 'type task date',
                labelText: 'task date',
                readOnly: true,
                onChanged: (String value) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task date';
                  }
                  return null;
                },
                onTap: () {
                  controller.onDateFieldTap(context);
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                controller: controller.taskTimeController,
                textInputType: TextInputType.datetime,
                hintText: 'type task time',
                labelText: 'task time',
                readOnly: true,
                onChanged: (String value) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task time';
                  }
                  return null;
                },
                onTap: () {
                  controller.onTimeFieldTap(context);
                },
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: MaterialButton(
                  onPressed: controller.onNewTaskPressed,
                  child: Text(
                    'New Task',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 15.sp, color: AppColors.whiteColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
