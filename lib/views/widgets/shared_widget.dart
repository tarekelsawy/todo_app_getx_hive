import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_getx_hive/controllers/Home_controller.dart';
import 'package:todo_getx_hive/models/task.dart';
import 'package:todo_getx_hive/utils/colors.dart';
import 'package:todo_getx_hive/utils/constants.dart';

class BottomNavigationBarTabBuildr extends StatelessWidget {
  final bool isActive;
  final int index;
  const BottomNavigationBarTabBuildr(
      {Key? key, required this.isActive, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: .8.h, horizontal: .3.w),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : AppColors.primaryColor,
        borderRadius: isActive ? BorderRadius.circular(15.sp) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            AppConstants.icons[index],
            size: isActive ? 21.sp : 24.sp,
            color: isActive ? AppColors.primaryColor : Colors.white,
          ),
          if (isActive)
            Text(
              AppConstants.taskStatusName[index],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 14.sp),
            ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final int index;
  final HomeController controller;
  const TaskItem(
      {Key? key,
      required this.task,
      required this.index,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      onDismissed: (direction) {
        controller.onDismissible(index, task.taskStatus);
      },
      background: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text(
            'Deleting...',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.whiteColor,
                ),
          ),
        ),
      ),
      child: Container(
        height: 12.h,
        margin: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(27.sp),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              radius: 27.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    processTimePart1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.primaryColor,
                        ),
                  ),
                  Text(
                    processTimePart2,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                  Text(
                    task.date,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.whiteColor),
                  )
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  controller.onArchiveIconOfItemTap(index, task.taskStatus);
                },
                // onTap: () {},
                child: Icon(
                  Icons.archive_outlined,
                  size: 33.sp,
                  color: task.taskStatus == Status.archived
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                )),
            SizedBox(
              width: 1.5.w,
            ),
            InkWell(
                onTap: () {
                  controller.onDoneIconOfItemTap(index, task.taskStatus);
                },
                child: Icon(
                  Icons.check_circle,
                  size: 33.sp,
                  color: task.taskStatus == Status.done
                      ? AppColors.whiteColor
                      : AppColors.greyColor,
                )),
            SizedBox(
              width: .1.w,
            ),
          ],
        ),
      ),
    );
  }

  String get processTimePart2 => task.time.split(' ')[1];

  String get processTimePart1 => task.time.split(' ')[0];
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 15.sp, color: AppColors.primaryColor),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.text_fields),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: Colors.redAccent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: .3.w),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        hintText: hintText,
        fillColor: Colors.grey,
        labelText: labelText,
        contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 2.w),
      ),
      autofocus: true,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
    );
  }
}
