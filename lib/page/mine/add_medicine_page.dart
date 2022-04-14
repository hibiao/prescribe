import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/util/db_util.dart';
import 'package:prescribe/common/util/dialog_util.dart';
import 'package:prescribe/common/util/num_length_input_formatter.dart';
import 'package:prescribe/page/mine/set_medicine_page.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class AddMedicinePage extends StatelessWidget {
  AddMedicinePage({Key? key}) : super(key: key);

  final TextEditingController _nameTec = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _salePriceTec = TextEditingController();
  final FocusNode _salePriceNode = FocusNode();
  final TextEditingController _purPriceTec = TextEditingController();
  final FocusNode _purPriceNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IAppBar(title: "添加药品",),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(50.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("药品名称",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _nameTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _nameNode,
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入药品名称'),
                            onSubmitted: (value){
                              _salePriceNode.requestFocus();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 25.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("售价",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _salePriceTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _salePriceNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              NumLengthInputFormatter(integerLength: 4)
                            ],
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入售价'),
                            onSubmitted: (value){
                              _purPriceNode.requestFocus();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.w,),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(width: 25.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("进价",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _purPriceTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _purPriceNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              NumLengthInputFormatter(integerLength: 4)
                            ],
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入进价'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.w,),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if(_nameTec.text == ''){
                    DiaLogUtil.show("您还没有填写药品名称");
                    return;
                  }
                  if((double.tryParse(_salePriceTec.text) ?? 0) <= 0){
                    DiaLogUtil.show("填写售价异常，请检查");
                    return;
                  }
                  if((double.tryParse(_purPriceTec.text) ?? 0) <= 0){
                    DiaLogUtil.show("填写进价异常，请检查");
                    return;
                  }
                  int res = await DBUtil.db!.insert("medicine", {
                    "name":_nameTec.text,
                    "sale_price":_salePriceTec.text,
                    "pur_price":_purPriceTec.text,
                    "img":"暂无"
                  });
                  if(res == 0){
                    DiaLogUtil.show("增加药品失败！");
                  }else {
                    MedicineModel medicineModel = Get.find<MedicineModel>();
                    medicineModel.refreshData();
                    Get.back();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                    color: AppColors.mainColor
                  ),
                  child: Text("保存",style: TextStyle(fontSize: 30.sp,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateMedicinePage extends StatelessWidget {
  final MedicineBean medicineBean;
  UpdateMedicinePage({Key? key, required this.medicineBean}) : super(key: key);

  final TextEditingController _nameTec = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _salePriceTec = TextEditingController();
  final FocusNode _salePriceNode = FocusNode();
  final TextEditingController _purPriceTec = TextEditingController();
  final FocusNode _purPriceNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _nameTec.text = medicineBean.name;
    _salePriceTec.text = medicineBean.salePrice.toString();
    _purPriceTec.text = medicineBean.purPrice.toString();
    return Scaffold(
      appBar: const IAppBar(title: "添加药品",),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(50.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("药品名称",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _nameTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _nameNode,
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入药品名称'),
                            onSubmitted: (value){
                              _salePriceNode.requestFocus();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 25.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("售价",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _salePriceTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _salePriceNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              NumLengthInputFormatter(integerLength: 4)
                            ],
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入售价'),
                            onSubmitted: (value){
                              _purPriceNode.requestFocus();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.w,),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(width: 25.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("进价",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 24.sp,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 15.w,),
                        Container(
                          height: 65.w,
                          padding:EdgeInsets.only(left: 25.w,right: 25.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.w)),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              )
                          ),
                          child: TextField(
                            controller: _purPriceTec,
                            style: TextStyle(fontSize: 24.sp),
                            focusNode: _purPriceNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              NumLengthInputFormatter(integerLength: 4)
                            ],
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(top: 0, bottom: 0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: TextStyle(fontSize: 24.sp,color: const Color(0xFF999999)),
                                hintText: '输入进价'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.w,),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if(_nameTec.text == ''){
                    DiaLogUtil.show("您还没有填写药品名称");
                    return;
                  }
                  if((double.tryParse(_salePriceTec.text) ?? 0) <= 0){
                    DiaLogUtil.show("填写售价异常，请检查");
                    return;
                  }
                  if((double.tryParse(_purPriceTec.text) ?? 0) <= 0){
                    DiaLogUtil.show("填写进价异常，请检查");
                    return;
                  }
                  Map<String, Object?> dataMap = {
                    "name":_nameTec.text,
                    "sale_price":_salePriceTec.text,
                    "pur_price":_purPriceTec.text,
                    "img":"暂无"
                  };
                  int res = await DBUtil.db!.update("medicine", dataMap, where: "id = ${medicineBean.id}");
                  if(res == 0){
                    DiaLogUtil.show("增加药品失败！");
                  }else {
                    MedicineModel medicineModel = Get.find<MedicineModel>();
                    medicineModel.refreshData();
                    Get.back();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: AppColors.mainColor
                  ),
                  child: Text("更新",style: TextStyle(fontSize: 30.sp,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
