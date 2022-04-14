import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IAppBar(title: "赏一个",),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 750.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.w,
              ),
              Text("微信赞赏码：", style: TextStyle(fontSize: 30.sp,color: AppColors.mainColor),),
              SizedBox(
                height: 20.w,
              ),
              Image.asset(
                  "assets/images/weixin.png",
                width: 300.w,
                height: 300.w,
              ),
              SizedBox(
                height: 50.w,
              ),
              Text("支付宝：", style: TextStyle(fontSize: 30.sp,color: AppColors.mainColor),),
              SizedBox(
                height: 20.w,
              ),
              Image.asset(
                "assets/images/zhifubao.png",
                width: 300.w,
                height: 300.w,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
