import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/common/getx/getx_widget.dart';
import 'package:prescribe/common/getx/view_state_layout.dart';
import 'package:prescribe/page/graphic/model/graphic_model.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class GraphicPage extends StatefulWidget {
  const GraphicPage({Key? key}) : super(key: key);

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const IAppBar(title: "统计",isBack: false,),
      body: GetxWidget<GraphicModel>(
        model: Get.put(GraphicModel()),
        onModelReady: (model){
          model.initData();
        },
          builder: (model){
            return ViewStateLayout(model: model,builder: (){
              GraphicData graphicData = model.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(50.w),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 1
                        )
                      ),
                      child: RichText(
                          text:TextSpan(
                            text: "您本月销售了",
                            style: TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),
                            children: [
                              TextSpan(
                                text: graphicData.currentGraphicBean.count.toString() + "单，",
                                style: TextStyle(color: Colors.red,fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: "销售总价",
                                style: TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: graphicData.currentGraphicBean.salePrice.toStringAsFixed(2) + "元，",
                                style: TextStyle(color: Colors.red,fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: "您的成本为",
                                style: TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: graphicData.currentGraphicBean.purPrice.toStringAsFixed(2) + "元，",
                                style: TextStyle(color: Colors.red,fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: "您本月盈利",
                                style: TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),
                              ),
                              TextSpan(
                                text: NumUtil.subtract(graphicData.currentGraphicBean.salePrice, graphicData.currentGraphicBean.purPrice).toStringAsFixed(2) + "元。",
                                style: TextStyle(color: Colors.red,fontSize: 30.sp),
                              )
                            ]
                          )
                      ),
                    ),
                    Text("本月数据趋势",style:TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),),
                    SizedBox(
                      height: 400.w,
                      child: Chart(
                          data: graphicData.monthGraphicBeans,
                          variables: {
                            '日期': Variable(
                              accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.text,
                              scale: OrdinalScale(),
                            ),
                            '销售额': Variable(
                              accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.num,
                              scale: LinearScale(),
                            ),
                            'groupBy': Variable(
                              accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.groupBy,
                            ),
                          },
                          elements: [
                            LineElement(
                              position: Varset('日期') * Varset('销售额') / Varset('groupBy'),
                              shape: ShapeAttr(value: BasicLineShape()),
                              color: ColorAttr(
                                variable: "groupBy",
                                values: [AppColors.mainColor, Colors.orange, Colors.blue],
                              ),
                            ),
                            PointElement(
                              color: ColorAttr(
                                  values: [AppColors.mainColor, Colors.orange, Colors.blue],
                                  variable: "groupBy"
                              ),
                            ),
                          ],
                        axes: [
                          Defaults.horizontalAxis,
                          Defaults.verticalAxis,
                        ],
                      ),

                    ),
                    SizedBox(
                      height: 50.w,
                    ),
                    Text("本年数据趋势",style:TextStyle(color: const Color(0xFF212121),fontSize: 30.sp),),
                    SizedBox(
                      height: 400.w,
                      child: Chart(
                        data: graphicData.yearGraphicBeans,
                        variables: {
                          '日期': Variable(
                            accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.text,
                            scale: OrdinalScale(),
                          ),
                          '销售额': Variable(
                            accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.num,
                            scale: LinearScale(),
                          ),
                          'groupBy': Variable(
                            accessor: (GraphicChartBean graphicChartBean) => graphicChartBean.groupBy,
                          ),
                        },
                        elements: [
                          LineElement(
                            position: Varset('日期') * Varset('销售额') / Varset('groupBy'),
                            shape: ShapeAttr(value: BasicLineShape()),
                            color: ColorAttr(
                              variable: "groupBy",
                              values: [AppColors.mainColor, Colors.orange, Colors.blue],
                            ),
                          ),
                          PointElement(
                            color: ColorAttr(
                                values: [AppColors.mainColor, Colors.orange, Colors.blue],
                                variable: "groupBy"
                            ),
                          ),
                        ],
                        axes: [
                          Defaults.horizontalAxis,
                          Defaults.verticalAxis,
                        ],
                      ),

                    ),
                  ],
                ),
              );
            },);
          }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
