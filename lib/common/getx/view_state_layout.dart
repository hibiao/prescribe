import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStateLayout extends StatelessWidget {
  final dynamic model;
  final Widget Function() builder;
  final bool isShowLoading;
  final Widget? onLoading;
  final Widget? onError;
  final Widget? onEmpty;
  final bool isShowUnloginPage;

  const ViewStateLayout({Key? key,
    required this.model,
    required this.builder,
    this.isShowLoading = true,
    this.onLoading,
    this.onError,
    this.onEmpty,
    this.isShowUnloginPage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isShowLoading && model.busy) {
      return onLoading ?? const ViewStateLoading();
    }
    if (model.error) {
      return onError ?? ViewStateError(message: model.errorMessage, onPressed: ()=>model.initData(),);
    }
    if (model.empty) {
      return onEmpty ?? ViewStateEmpty(onPressed: model.initData);
    }
    if (isShowUnloginPage && model.unAuthorized) {
      return ViewStateError(
        showBtn: true,
        buttonText: const Text('登录'),
        message: '请先登录',
        onPressed: () {

        },
      );
    }
    return builder();
  }
}

class ViewStateLoading extends StatelessWidget {
  const ViewStateLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CupertinoActivityIndicator(),
          SizedBox(height: 10.w,),
          Text('加载中', style: TextStyle(fontSize: 20.sp, color: Colors.black54,),),
        ],
      ),
    );
  }
}

class ViewStateEmpty extends StatelessWidget {
  final Widget? image;
  final String? message;
  final Widget? buttonText;
  final VoidCallback onPressed;
  final bool showBtn;

  const ViewStateEmpty({Key? key, this.image, this.message, this.buttonText, required this.onPressed, this.showBtn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: showBtn ? null : onPressed,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            image ?? Icon(Icons.error, size: 120.w, color: Colors.grey[500]),
            SizedBox(height: 10.w,),
            Text(message ?? '空空如也',style: TextStyle(color: Colors.grey, fontSize: 28.sp),),
            showBtn ? GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 200.w,
                height: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.w
                  )
                ),
                child: Text("请重试",style: TextStyle(color: Colors.grey, fontSize: 28.sp)),
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}

class ViewStateError extends StatelessWidget {
  final Widget? image;
  final String? message;
  final Widget? buttonText;
  final VoidCallback onPressed;
  final bool showBtn;

  const ViewStateError({Key? key, this.image, this.message, this.buttonText, required this.onPressed, this.showBtn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: showBtn ? null : onPressed,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            image ?? Icon(Icons.error, size: 120.w, color: Colors.grey[500]),
            SizedBox(height: 10.w,),
            Text(message ?? '出错啦',style: TextStyle(color: Colors.grey, fontSize: 28.sp),),
            showBtn ? GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 200.w,
                height: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                    border: Border.all(
                        color: Colors.grey,
                        width: 1.w
                    )
                ),
                child: Text("请重试",style: TextStyle(color: Colors.grey, fontSize: 28.sp)),
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}

