import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_getx_hive/utils/colors.dart';
import 'package:todo_getx_hive/utils/constants.dart';

class BottomNavigationBarTabBuildr extends StatelessWidget {
  final bool isActive;
  final int index;
  const BottomNavigationBarTabBuildr({Key? key, required this.isActive, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: .8.h,horizontal: .3.w),
      decoration: BoxDecoration(
        color: isActive?Colors.white:AppColors.primaryColor,
        borderRadius: isActive? BorderRadius.circular(15.sp):null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(AppConstants.icons[index],size:isActive? 21.sp:24.sp,color:isActive?AppColors.primaryColor: Colors.white,),
          if(isActive)
            Text(AppConstants.taskStatusName[index],style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor,fontSize: 14.sp ),),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            radius: 26.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '8:30',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  'AM',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60.w,
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'play football play football play football',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Text('2/19/2023',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.whiteColor),)
            ],
          ),
          const Spacer(),
          InkWell(
              onTap: (){
              },
              child: Icon(Icons.check_circle,size: 35.sp,color: AppColors.greyColor,)),
          SizedBox(width: 2.w,),
        ],
      ),
    );
  }
}

