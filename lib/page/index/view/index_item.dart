import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/page/index/index_page.dart';

class IndexItem extends StatelessWidget {
  final PrescribeBean prescribeBean;
  const IndexItem({Key? key, required this.prescribeBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w,right: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.w,),
          Row(
            children: [
              Expanded(child: Text(prescribeBean.name, style: TextStyle(fontSize: 30.sp),)),
              Text("¥${prescribeBean.salePrice}", style: TextStyle(fontSize: 30.sp,color: Colors.red),)
            ],
          ),
          SizedBox(height: 10.w,),
          Row(
            children: [
              Expanded(child: Text("", style: TextStyle(fontSize: 30.sp),)),
              Text(prescribeBean.creatTime, style: TextStyle(fontSize: 30.sp,color: Colors.grey),)
            ],
          ),
          SizedBox(height: 20.w,),
          Container(
            height: 1.w,
            color: AppColors.lightGrey,
          )
        ],
      ),
    );
  }
}
