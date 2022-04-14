import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prescribe/tabbar_page.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GoMainView extends StatefulWidget {
  const GoMainView({Key? key}) : super(key: key);

  @override
  State<GoMainView> createState() => _GoMainViewState();
}

class _GoMainViewState extends State<GoMainView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding widgetsBinding = WidgetsBinding.instance!;
    widgetsBinding.addPostFrameCallback((Duration timeStamp){
      Get.offAll(() => TabBarPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

