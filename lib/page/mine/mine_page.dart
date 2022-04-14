import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescribe/page/mine/about_me_page.dart';
import 'package:prescribe/page/mine/donate_page.dart';
import 'package:prescribe/page/mine/set_medicine_page.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const IAppBar(
        title: "设置",
        isBack: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.to(()=>const SetMedicinePage());
              },
                child: const MineItem(icon: Icons.settings,title: "药品管理",)
            ),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.to(()=>const AboutMePage());
                },
                child: const MineItem(icon: Icons.person,title: "关于我",)
            ),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.to(()=>const DonatePage());
                },
                child: const MineItem(icon: Icons.monetization_on_outlined,title: "赞赏",)
            ),
          ],
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class MineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const MineItem({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.w,right: 30.w,top: 30.w),
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          border: Border.all(
              color: Colors.grey,
              width: 1.w
          )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon,color: Colors.grey,size: 28.w,),
              SizedBox(width: 20.w,),
              Expanded(child: Text(title, style: TextStyle(fontSize: 30.sp),)),
              SizedBox(width: 20.w,),
              Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 28.w,)
            ],
          ),
        ],
      ),
    );
  }
}
