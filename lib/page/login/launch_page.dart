import 'package:flutter/material.dart';
import 'package:prescribe/common/util/db_util.dart';
import 'package:prescribe/page/login/view/splash_view.dart';
import 'package:sp_util/sp_util.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  ///app启动时进行一些初始化的工作。
  Future<bool> initAppLaunch() async {
    await SpUtil.getInstance();
    await DBUtil.getInstance();
    ///在这里可以进行是否首次启动app的判断，这里暂时不需要。直接返回了true
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAppLaunch(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          return const GoMainView();
        }else {
          return const SplashView();
        }
      },);
  }
}


