import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/getx/getx_widget.dart';
import 'package:prescribe/common/getx/view_state_layout.dart';
import 'package:prescribe/common/getx/view_state_list_model.dart';
import 'package:prescribe/common/util/db_util.dart';
import 'package:prescribe/common/util/dialog_util.dart';
import 'package:prescribe/page/mine/add_medicine_page.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class SetMedicinePage extends StatelessWidget {
  const SetMedicinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        title: "药品管理",
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>AddMedicinePage());
            },
              child: Padding(
                padding: EdgeInsets.only(right: 25.w),
                  child: Icon(Icons.add,size: 50.w,color: Colors.white,)
              )
          )
        ],
      ),
      body: GetxWidget<MedicineModel>(
        model: Get.put(MedicineModel()),
        onModelReady: (model){
          model.initData();
        },
        builder: (model){
          return ViewStateLayout(model: model, builder: (){
            return ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
                MedicineBean medicineBean = model.list[index];
                return SwipeActionCell(
                  key: ValueKey(medicineBean.id),
                  trailingActions: [
                    SwipeAction(
                        title: "删除",
                        onTap: (CompletionHandler handler) async {
                          int count = await DBUtil.db!.delete("medicine",where: "id = ${medicineBean.id}");
                          if(count > 0){
                            model.list.removeAt(index);
                            model.update();
                          }
                        }
                    )
                  ],
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.to(()=>UpdateMedicinePage(medicineBean: medicineBean));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w,right: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.w,),
                          Row(
                            children: [
                              Expanded(child: Text(medicineBean.name,style: TextStyle(fontSize: 30.sp,color: const Color(0xFF212121)),)),
                              Text("售价：¥${medicineBean.salePrice}",style: TextStyle(fontSize: 30.sp,color: Colors.red),)
                            ],
                          ),
                          SizedBox(height: 15.w,),
                          Row(
                            children: [
                              Expanded(child: Text("",style: TextStyle(fontSize: 30.sp,color: const Color(0xFF212121)),)),
                              Text("进价：¥${medicineBean.purPrice}",style: TextStyle(fontSize: 30.sp,color: Colors.red),)
                            ],
                          ),
                          SizedBox(height: 20.w,),
                          Container(height: 1.w, color: Colors.grey,)
                        ],
                      ),
                    ),
                  ),
                );
              },);
          });
        },
      ),
    );
  }
}

class MedicineBean {
  late int id;
  late String name;
  late double salePrice;
  late double purPrice;
  late String img;

  MedicineBean.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    salePrice = map["sale_price"];
    purPrice = map["pur_price"];
    img = map["img"];
  }
}

class MedicineModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    try {
      List listTemp = await DBUtil.db!.query("medicine",orderBy: "id desc");
      return listTemp.map((item) => MedicineBean.fromMap(item)).toList();
    } catch (error){
      DiaLogUtil.show(error.toString());
      return [];
    }
  }
}
