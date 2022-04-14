import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'view_state.dart';

abstract class ViewStateListModel<T> extends GetxController {
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

  /// 初始化数据
  initData() async {
    setBusy(true);
    await refreshData();
  }

  /// 刷新数据
  refreshData() async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        list = [];
        setEmpty();
      } else {
        list = data;
        setBusy(false);
      }
    } catch (e, s) {
      handleCatch(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

}