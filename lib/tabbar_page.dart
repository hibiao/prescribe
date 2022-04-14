import 'package:flutter/material.dart';
import 'package:prescribe/common/constant/app_colors.dart';
import 'package:prescribe/page/graphic/graphic_page.dart';
import 'package:prescribe/page/index/index_page.dart';
import 'package:prescribe/page/mine/mine_page.dart';

class TabBarPage extends StatelessWidget {
  TabBarPage({Key? key}) : super(key: key);


  late StateSetter _bottomNavStateSetter;
  int _currentIndex = 0;

  final PageController _pageController = PageController(
    initialPage: 0, //默认在第几个
    viewportFraction: 1, // 占屏幕多少，1为占满整个屏幕
    keepPage: true,
  );


  ///底部的TabBarItem
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
        label: "药方",
        icon: Icon(Icons.home)
    ),
    const BottomNavigationBarItem(
        label:"统计",
        icon: Icon(Icons.analytics)
    ),
    const BottomNavigationBarItem(
        label:"设置",
        icon: Icon(Icons.settings)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          IndexPage(),
          GraphicPage(),
          MinePage()
        ],
        onPageChanged: (index){
          _bottomNavStateSetter(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          _bottomNavStateSetter = setState;
          return Theme(
            data: ThemeData(
              brightness: Brightness.light,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              mouseCursor: MouseCursor.defer,
              currentIndex: _currentIndex,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: AppColors.mainColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: _items,
              onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
                _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
              },
            ),
          );
        },
      )
    );
  }
}
