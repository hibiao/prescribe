import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiaLogUtil {

  static show(String msg) {
    BotToast.showText(text: msg,align: const Alignment(0, 0));
  }

  /// 显示加载中弹框
  static showLoading() {
    var fun = BotToast.showCustomLoading(
      clickClose: false,
      toastBuilder: (can) {
        return Container(
          padding: EdgeInsets.all(40.w),
          decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            backgroundColor: Colors.white,
          ),
        );
      },
    );
    return fun;
  }

  /// 显示对话框
  static Future showCustomDialog(BuildContext context, {required Widget dialogUI, bool barrierDismissible=true}) async {
    return await showGeneralDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        //背景颜色
        barrierDismissible: barrierDismissible,
        //是否点击背景,关闭对话框
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 250),
        transitionBuilder: _buildMaterialDialogTransitions,
        pageBuilder: (context, b, c) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                type: MaterialType.transparency, //透明的
                child: WillPopScope(
                  onWillPop: () {
                    return Future.value(true); // 是否可以点击back按键,关闭对话框
                  },
                  child: AvoidKeyboard(child: dialogUI),
                ),
              ),
            ],
          );
        });
  }

  static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    Animation<Offset> custom = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(animation);

    return SlideTransition(
      position: custom,
      child: child,
    );
  }
}