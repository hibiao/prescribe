import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';

class IAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool hasBackGround;

  const IAppBar({Key? key, required this.title, this.isBack = true, this.actions, this.leading, this.bottom, this.hasBackGround = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 34.sp, color: Colors.white, fontWeight: FontWeight.w400),),
      centerTitle: true,
      actions: actions,
      backgroundColor: AppColors.mainColor,
      leading: leading ?? Visibility(
        visible: isBack,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            Get.back();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 25.w,),
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 40.w,
              )
            ],
          ),
        ),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
