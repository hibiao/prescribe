import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/getx/getx_widget.dart';
import 'package:prescribe/common/getx/view_state_layout.dart';
import 'package:prescribe/common/getx/view_state_list_model.dart';
import 'package:prescribe/common/getx/view_state_refresh_list_model.dart';
import 'package:prescribe/common/util/db_util.dart';
import 'package:prescribe/common/util/dialog_util.dart';
import 'package:prescribe/page/index/add_prescribe_page.dart';
import 'package:prescribe/page/index/prescribe_detail_page.dart';
import 'package:prescribe/page/index/view/index_item.dart';
import 'package:prescribe/widgets/i_appbar.dart';
import 'package:prescribe/widgets/i_listview_builder.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const IAppBar(
        title: "药方",
        isBack: false,
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.to(()=>AddPrescribePage());
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.all(Radius.circular(50.w))
          ),
          child: Icon(Icons.add,color: Colors.white,size: 80.w,),
        ),
      ),
      body: GetxWidget<PrescribeModel>(
        model: Get.put(PrescribeModel()),
        onModelReady: (model){
          model.initData();
        },
        builder: (model){
          return ViewStateLayout(model: model, builder: (){
            return IListViewBuilder(
              model: model,
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
                PrescribeBean prescribeBean = model.list[index];
                return SwipeActionCell(
                  key: ValueKey(prescribeBean.id),
                  trailingActions: [
                    SwipeAction(
                        title: "删除",
                        onTap: (CompletionHandler handler) async {
                          int count0 = await DBUtil.db!.delete("sale_medicine",where: "pid = ${prescribeBean.id}");
                          int count1 = await DBUtil.db!.delete("prescribe",where: "id = ${prescribeBean.id}");
                          if(count1 > 0){
                            model.list.removeAt(index);
                            model.update();
                          }
                        }
                    )
                  ],
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.to(()=>PrescribeDetailPage(prescribeBean: prescribeBean,));
                    },
                    child: IndexItem(prescribeBean: prescribeBean,),
                  ),
                );
              },);
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PrescribeBean {
  late int id;
  late String name;
  late double salePrice;
  late double purPrice;
  late String creatTime;

  PrescribeBean.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    salePrice = map["sale_price"];
    purPrice = map["pur_price"];
    creatTime = map["creat_time"];
  }
}

class SaleMedicineBean {
  late int id;
  late int pid;
  late String name;
  late double salePrice;
  late double purPrice;
  late int quantity;
  late String img;

  SaleMedicineBean.fromMap(Map map){
    id = map["id"] ?? -1;
    pid = map["pid"] ?? -1;
    name = map["name"];
    salePrice = map["sale_price"];
    purPrice = map["pur_price"];
    quantity = map["quantity"];
    img = map["img"];
  }

  Map<String, Object?> toMap(){
    return {
      "name":name,
      "sale_price":salePrice,
      "pur_price":purPrice,
      "quantity":quantity,
      "img":img,
    };
  }
}

class PrescribeModel extends ViewStateRefreshListModel{
  @override
  Future<List> loadData({required int pageNum}) async {
    try {
      List listTemp = await DBUtil.db!.query("prescribe",orderBy: "id desc",limit: 15,offset: (pageNum-1)*15);
      return listTemp.map((item) => PrescribeBean.fromMap(item)).toList();
    } catch (error){
      DiaLogUtil.show(error.toString());
      return [];
    }
  }
}

class SaleMedicineModel extends ViewStateListModel {

  final int pid;
  SaleMedicineModel(this.pid);

  @override
  Future<List> loadData() async {
    try {
      List listTemp = await DBUtil.db!.query("sale_medicine",where: "pid = $pid");
      return listTemp.map((item) => SaleMedicineBean.fromMap(item)).toList();
    } catch (error){
      DiaLogUtil.show(error.toString());
      return [];
    }
  }
}
