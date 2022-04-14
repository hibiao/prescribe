import 'package:flutter/material.dart';
import 'package:prescribe/common/getx/view_state_refresh_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IListViewBuilder extends StatelessWidget {

  final int? itemCount;
  final ViewStateRefreshListModel? model;
  final IndexedWidgetBuilder itemBuilder;
  final bool enablePullUp;
  final bool enablePullDown;
  final Widget? header;
  final Widget? footer;

  const IListViewBuilder({
    Key? key,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.itemCount,
    this.model,
    this.header,
    this.footer,
    required this.itemBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model == null){
      return ListView.builder(
          itemCount: itemCount,
          itemBuilder: itemBuilder
      );
    }else {
      return RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(
          refreshingText: "加载中···",
          idleText: "下拉加载",
          releaseText: "松手进行加载",
          completeText: "数据刷新成功",
          failedText: "数据刷新失败",
        ),
        footerBuilder: () => const ClassicFooter(
          //注意这里的footer因为axisDirection设置的关系是在屏幕上端，从而实现下拉加载消息历史
          loadingText: "加载中···",
          idleText: "上拉加载",
          canLoadingText: "加载中···",
          noDataText: "没有更多数据了",
          failedText: "没有更多数据了",
        ),
        child: SmartRefresher(
          controller: model!.refreshController,
          onRefresh: model!.refreshData,
          onLoading: model!.loadMore,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: itemBuilder
          )
        ),
      );
    }
  }

}
