import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/getx/getx_widget.dart';
import 'package:prescribe/common/getx/view_state_layout.dart';
import 'package:prescribe/page/index/add_prescribe_with_old_page.dart';
import 'package:prescribe/page/index/index_page.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class PrescribeDetailPage extends StatelessWidget {
  final PrescribeBean prescribeBean;

  const PrescribeDetailPage({Key? key, required this.prescribeBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        title: "药方详情",
        actions: [
          GestureDetector(
              onTap: (){
                SaleMedicineModel saleMedicineModel = Get.find();
                Get.to(()=>AddPrescribeWithOldPage(saleMedicineBeans: saleMedicineModel.list));
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 25.w),
                  child: Icon(Icons.add,size: 50.w,color: Colors.white,)
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w,right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(prescribeBean.name,style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height: 20.w,),
              Container(
                height: 1.w,
                color: AppColors.mainColor,
              ),
              SizedBox(height: 20.w,),
              Container(
                constraints: BoxConstraints(
                  minHeight: 500.w
                ),
                child: GetxWidget<SaleMedicineModel>(
                  model: Get.put(SaleMedicineModel(prescribeBean.id)),
                  onModelReady: (model){
                    model.initData();
                  },
                  builder: (model){
                    return ViewStateLayout(model: model, builder: (){
                      return Wrap(
                        textDirection: TextDirection.ltr,
                        spacing: 20.w,
                        runSpacing: 20.w,
                        children: List.generate(model.list.length, (index){
                          SaleMedicineBean saleMedicineBean = model.list[index];
                          return Text("${saleMedicineBean.name} * ${saleMedicineBean.quantity}",style: TextStyle(fontSize: 30.sp),);
                        }),
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 20.w,),
              Container(
                height: 1.w,
                color: AppColors.mainColor,
              ),
              SizedBox(height: 20.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prescribeBean.creatTime,style: TextStyle(fontSize: 24.sp,color: Colors.grey),),
                  Column(
                    children: [
                      Text("售价：¥${prescribeBean.salePrice}",style: TextStyle(fontSize: 24.sp, color: Colors.red),),
                      SizedBox(width: 10.w,),
                      Text("成本：¥${prescribeBean.purPrice}",style: TextStyle(fontSize: 24.sp,color: Colors.green),),
                      SizedBox(width: 10.w,),
                      Text("盈利：¥${NumUtil.subtract(prescribeBean.salePrice, prescribeBean.purPrice)}",style: TextStyle(fontSize: 24.sp,color: AppColors.mainColor),),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
