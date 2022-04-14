import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/getx/getx_widget.dart';
import 'package:prescribe/common/getx/view_state_layout.dart';
import 'package:prescribe/common/util/db_util.dart';
import 'package:prescribe/common/util/dialog_util.dart';
import 'package:prescribe/page/index/index_page.dart';
import 'package:prescribe/page/index/view/add_sale_medicine_view.dart';
import 'package:prescribe/page/index/view/edit_sale_medicine_view.dart';
import 'package:prescribe/page/mine/set_medicine_page.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class AddPrescribeWithOldPage extends StatelessWidget {
  final List saleMedicineBeans;
  AddPrescribeWithOldPage({Key? key, required this.saleMedicineBeans}) : super(key: key);

  final TextEditingController _nameTec = TextEditingController();
  final List<SaleMedicineBean> _saleMedicines = [];
  late void Function(void Function()) _setState;

  @override
  Widget build(BuildContext context) {
    _saleMedicines.addAll(saleMedicineBeans.cast());
    return Scaffold(
      appBar: IAppBar(
        title: "开药方",
        actions: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                if(_nameTec.text == ''){
                  DiaLogUtil.show("请填写药方名称");
                  return;
                }
                if(_saleMedicines.isEmpty){
                  DiaLogUtil.show("您还没有开药");
                  return;
                }
                String timeStr = DateUtil.formatDate(DateTime.now(),format: DateFormats.y_mo_d_h_m);
                double totalSale = 0;
                double totalPur = 0;
                for(SaleMedicineBean saleMedicineBean in _saleMedicines){
                  totalSale = NumUtil.add(totalSale, NumUtil.multiply(saleMedicineBean.salePrice, saleMedicineBean.quantity));
                  totalPur = NumUtil.add(totalPur, NumUtil.multiply(saleMedicineBean.purPrice, saleMedicineBean.quantity));
                }
                int res = await DBUtil.db!.insert("prescribe", {
                  "name":_nameTec.text,
                  "sale_price":totalSale,
                  "pur_price":totalPur,
                  "creat_time":timeStr
                });
                if(res > 0){
                  for(SaleMedicineBean saleMedicineBean in _saleMedicines){
                    DBUtil.db!.insert("sale_medicine", {
                      "pid":res,
                      "name":saleMedicineBean.name,
                      "sale_price":saleMedicineBean.salePrice,
                      "pur_price":saleMedicineBean.purPrice,
                      "quantity":saleMedicineBean.quantity,
                      "img":"暂无",
                    });
                  }
                  PrescribeModel prescribeModel = Get.find<PrescribeModel>();
                  prescribeModel.refreshData();
                  Get.close(2);
                }
              },
              child: Container(
                  width: 120.w,
                  alignment: Alignment.center,
                  child: Text("保存",style: TextStyle(color: Colors.white,fontSize: 30.sp,fontWeight: FontWeight.bold),)
              )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.w,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400.w,
                  height: 65.w,
                  padding:EdgeInsets.only(left: 25.w,right: 25.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )
                  ),
                  child: TextField(
                    controller: _nameTec,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.sp),
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
                        hintText: '请输入药方名称'),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.w,),
            Container(
              height: 1.w,
              color: AppColors.mainColor,
            ),
            SizedBox(height: 20.w,),
            Expanded(child: SingleChildScrollView(
                child: GetxWidget<MedicineModel>(
                  model: Get.put(MedicineModel()),
                  onModelReady: (model){
                    model.initData();
                  },
                  builder: (model){
                    return ViewStateLayout(model: model, builder: (){
                      return Wrap(
                        spacing: 10.w,
                        runSpacing: 10.w,
                        children: List.generate(model.list.length, (index){
                          MedicineBean medicineBean = model.list[index];
                          return GestureDetector(
                            onTap: (){
                              DiaLogUtil.showCustomDialog(context, dialogUI: AddSaleMedicineView(medicineBean: medicineBean,)).then((value){
                                if(value != null){
                                  SaleMedicineBean saleMedicineBean = value;
                                  _setState((){
                                    _saleMedicines.add(saleMedicineBean);
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.w,bottom: 10.w),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10.w))
                              ),
                              child: Text(medicineBean.name,style: TextStyle(fontSize: 30.sp,color: Colors.white),),
                            ),
                          );
                        }),
                      );
                    });
                  },
                )
            )),
            SizedBox(height: 20.w,),
            Container(
              height: 1.w,
              color: AppColors.mainColor,
            ),
            SizedBox(height: 20.w,),
            Expanded(child: SingleChildScrollView(
                child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                  _setState = setState;
                  return Wrap(
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: List.generate(_saleMedicines.length, (index){
                      SaleMedicineBean saleMedicineBean = _saleMedicines[index];
                      return PopupMenuButton(
                        offset: Offset(20.w,20.w),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(value: "修改", child: Text("修改",style: TextStyle(fontSize: 30.sp),),),
                            PopupMenuItem<String>(value: "删除", child: Text("删除",style: TextStyle(fontSize: 30.sp),),)
                          ];
                        },
                        onSelected: (String action){
                          if(action == '修改'){
                            DiaLogUtil.showCustomDialog(context, dialogUI: EditSaleMedicineView(saleMedicineBean: saleMedicineBean,)).then((value){
                              setState((){});
                            });
                          }
                          if(action == '删除'){
                            setState((){
                              _saleMedicines.removeAt(index);
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.w,bottom: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(10.w))
                          ),
                          child: Text("${saleMedicineBean.name} * ${saleMedicineBean.quantity}",style: TextStyle(fontSize: 30.sp,color: Colors.white),),
                        ),
                      );
                    }),
                  );
                },)
            )),
          ],
        ),
      ),
    );
  }
}
