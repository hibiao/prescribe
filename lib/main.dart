import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:prescribe/page/login/launch_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context) {
        final botToastBuilder = BotToastInit();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: '药方管理',
          builder: (context,child){
            ScreenUtil.setContext(context);
            child = botToastBuilder(context,child);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(),
              child: child,
            );
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
          ],
          home: const LaunchPage(),
        );
      },
    );
  }
}

