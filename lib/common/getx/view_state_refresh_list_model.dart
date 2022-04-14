import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'view_state.dart';

abstract class ViewStateRefreshListModel<T> extends GetxController {

  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为idle
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    update();
  }

  /// 出错时的message
  String? _errorMessage;

  String get errorMessage => _errorMessage!;

  /// 以下变量是为了代码书写方便,加入的变量.严格意义上讲,并不严谨

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  void setBusy(bool value) {
    _errorMessage = null;
    viewState = value ? ViewState.busy : ViewState.idle;
  }

  void setEmpty() {
    _errorMessage = null;
    viewState = ViewState.empty;
  }

  void setError(String message) {
    _errorMessage = message;
    viewState = ViewState.error;
  }

  void setUnAuthorized() {
    _errorMessage = null;
    viewState = ViewState.unAuthorized;
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _errorMessage: $_errorMessage,_list: $list}_${super.toString()}';
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    if(!_disposed){
      super.update(ids, condition);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _refreshController.dispose();
    super.dispose();
  }

  /// Handle Error and Exception
  ///
  /// 统一处理子类的异常情况
  /// [e],有可能是Error,也有可能是Exception.所以需要判断处理
  /// [s] 为堆栈信息
  void handleCatch(e, s) {
    debugPrint('Error---> ' + e.toString());
    debugPrint('statck---> ' + s.toString());
    setError('Error');
  }

  /// 页面数据
  List<T> list = [];

  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  int _pageSize = 15;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  int get currentPageNum => _currentPageNum;

  /// 初始化数据
  initData({int pageSize = 15}) async {
    _pageSize = pageSize;
    setBusy(true);
    await refreshData();
  }

  // 加载数据
  Future<List<T>> loadData({required int pageNum});

  /// 下拉刷新
  Future<List<T>> refreshData() async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data.isEmpty) {
        list = [];
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < _pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        //改变页面状态为非加载中
        setBusy(false);
      }
      return data;
    } catch (e, s) {
      list = [];
      handleCatch(e, s);
      return [];
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
//        if (_currentPageNum != 1) {
        refreshController.loadNoData();
//        }
      } else {
        list.addAll(data);
        if (data.length < _pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        update();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      if (kDebugMode) {
        print('error--->\n' + e.toString());
        print('statck--->\n' + s.toString());
      }
      return [];
    }
  }


  /// 下拉加载更多
  Future<List<T>> messageLoadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        //将新列表放在列表的前面
        list.insertAll(0, data);
        if (data.length < _pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
       update();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      if (kDebugMode) {
        print('error--->\n' + e.toString());
        print('statck--->\n' + s.toString());
      }
      return [];
    }
  }

}