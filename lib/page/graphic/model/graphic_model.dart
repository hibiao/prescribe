import 'package:prescribe/common/getx/view_state_model.dart';
import 'package:prescribe/common/util/db_util.dart';

class GraphicBean {
  double salePrice = 0;
  double purPrice = 0;
  int count = 0;
  String creatTime = "";

  GraphicBean();

  GraphicBean.fromMap(Map map){
    salePrice = map["sale_price"] ?? 0;
    purPrice = map["pur_price"] ?? 0;
    count = map["count"] ?? 0;
    creatTime = map["creat_time"] ?? "";
  }
}

class GraphicChartBean {
  late String text;
  double num = 0;
  late String groupBy;

  GraphicChartBean();
}

class GraphicData {
  GraphicBean currentGraphicBean = GraphicBean();
  List<GraphicChartBean> monthGraphicBeans = [];
  List<GraphicChartBean> yearGraphicBeans = [];
}

class GraphicModel extends ViewStateModel{
  @override
  Future getData() async {
    GraphicData graphicData = GraphicData();

    List curMonthData = await DBUtil.db!.rawQuery("""
    SELECT SUM(sale_price) AS sale_price, SUM(pur_price) AS pur_price, COUNT(*) AS count FROM prescribe where creat_time between datetime('now','start of month','+1 second') and datetime('now','start of month','+1 month','-1 second');
    """);
    if(curMonthData.isNotEmpty){
      Map curMonthMap = curMonthData.first;
      graphicData.currentGraphicBean = GraphicBean.fromMap(curMonthMap);
    }

    List listMonthGraphicMaos = await DBUtil.db!.rawQuery("""
    SELECT SUBSTR(creat_time,6,5) AS creat_time,SUM(sale_price) AS sale_price,SUM(pur_price) AS pur_price, COUNT(*) AS count FROM prescribe where creat_time between datetime('now','start of month','+1 second') and datetime('now','start of month','+1 month','-1 second') GROUP BY SUBSTR(creat_time,1,10);
    """);
    print(listMonthGraphicMaos);
    for(Map map in listMonthGraphicMaos){
      GraphicChartBean graphicChartBean = GraphicChartBean();
      graphicChartBean.text = map["creat_time"];
      graphicChartBean.num = map["sale_price"];
      graphicChartBean.groupBy = "sale_price";
      graphicData.monthGraphicBeans.add(graphicChartBean);
      GraphicChartBean graphicChartBean2 = GraphicChartBean();
      graphicChartBean2.text = map["creat_time"];
      graphicChartBean2.num = map["pur_price"];
      graphicChartBean2.groupBy = "pur_price";
      graphicData.monthGraphicBeans.add(graphicChartBean2);
      GraphicChartBean graphicChartBean3 = GraphicChartBean();
      graphicChartBean3.text = map["creat_time"];
      graphicChartBean3.num = map["count"].toDouble();
      graphicChartBean3.groupBy = "count";
      graphicData.monthGraphicBeans.add(graphicChartBean3);
    }


    List listyearGraphicMaos = await DBUtil.db!.rawQuery("""
    SELECT SUBSTR(creat_time,1,7) AS creat_time,SUM(sale_price) AS sale_price,SUM(pur_price) AS pur_price, COUNT(*) AS count FROM prescribe where creat_time between datetime('now','start of year','+1 second') and datetime('now','start of year','+1 year','-1 second') GROUP BY SUBSTR(creat_time,1,7);
    """);

    for(Map map in listyearGraphicMaos){
      GraphicChartBean graphicChartBean = GraphicChartBean();
      graphicChartBean.text = map["creat_time"];
      graphicChartBean.num = map["sale_price"];
      graphicChartBean.groupBy = "sale_price";
      graphicData.yearGraphicBeans.add(graphicChartBean);
      GraphicChartBean graphicChartBean2 = GraphicChartBean();
      graphicChartBean2.text = map["creat_time"];
      graphicChartBean2.num = map["pur_price"];
      graphicChartBean2.groupBy = "pur_price";
      graphicData.yearGraphicBeans.add(graphicChartBean2);
      GraphicChartBean graphicChartBean3 = GraphicChartBean();
      graphicChartBean3.text = map["creat_time"];
      graphicChartBean3.num = map["count"].toDouble();
      graphicChartBean3.groupBy = "count";
      graphicData.yearGraphicBeans.add(graphicChartBean3);
    }

    return graphicData;
  }
}