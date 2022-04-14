import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/util/dialog_util.dart';
import 'package:prescribe/common/util/num_length_input_formatter.dart';
import 'package:prescribe/page/index/index_page.dart';
import 'package:prescribe/page/mine/set_medicine_page.dart';

class EditSaleMedicineView extends StatelessWidget {
  final SaleMedicineBean saleMedicineBean;
  EditSaleMedicineView({Key? key, required this.saleMedicineBean}) : super(key: key);
  final TextEditingController _nameTec = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _salePriceTec = TextEditingController();
  final FocusNode _salePriceNode = FocusNode();
  final TextEditingController _quantityTec = TextEditingController();
  final FocusNode _quantityNode = FocusNode();
  final TextEditingController _purPriceTec = TextEditingController();
  final FocusNode _purPriceNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _nameTec.text = saleMedicineBean.name;
    _salePriceTec.text = saleMedicineBean.salePrice.toString();
    _purPriceTec.text = saleMedicineBean.purPrice.toString();
    _quantityTec.text = saleMedicineBean.quantity.toString();
    return Container(
      width: 650.w,
      padding: EdgeInsets.all(50.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w))
      ),
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
                          _quantityNode.requestFocus();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("数量",style: TextStyle(color: const Color(0xFF999999),fontSize: 24.sp,fontWeight: FontWeight.bold),),
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
                        controller: _quantityTec,
                        style: TextStyle(fontSize: 24.sp),
                        focusNode: _quantityNode,
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          NumLengthInputFormatter(integerLength: 4,allowInputDecimal: false)
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
                            hintText: '输入数量'),
                        onSubmitted: (value){
                          _purPriceNode.requestFocus();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: AppColors.mainColor
                  ),
                  child: Text("取消",style: TextStyle(fontSize: 28.sp,color: Colors.white),),
                ),
              ),
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
                  if((int.tryParse(_quantityTec.text) ?? 0) <= 0){
                    DiaLogUtil.show("填写数量异常，请检查");
                    return;
                  }
                  saleMedicineBean.name = _nameTec.text;
                  saleMedicineBean.salePrice = double.parse(_salePriceTec.text);
                  saleMedicineBean.purPrice = double.parse(_purPriceTec.text);
                  saleMedicineBean.quantity = int.parse(_quantityTec.text);
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: AppColors.mainColor
                  ),
                  child: Text("添加",style: TextStyle(fontSize: 28.sp,color: Colors.white),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
