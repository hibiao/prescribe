import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/widgets/i_appbar.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IAppBar(title: "关于",),
      body: Container(
        margin: EdgeInsets.all(50.w),
        child: Text("""
        该APP适用于中医开药方。可在药方页面点击 + 进行新增药方，也可在查看药方详情页的右上角，点击 + 进行新增药方，此时的话，会将现有的药方基础上进行增减。
        在统计页面，可查看药方数据的一些趋势。在设置页面，可以进行一些药品管理。在开药方的时候，会将设置过的药品提供给你供你选择，药品的价格会默认适用设置里的价格，当然，你可以手动进行修改。数量默认为5，你同样可以自由修改。
        如果你觉得这个APP对你有帮助，你可以在赞赏页面对我进行打赏，谢谢！
        
        2022.03.27
        """,style: TextStyle(fontSize: 30.sp,color: AppColors.mainColor),),
      ),

    );
  }
}
