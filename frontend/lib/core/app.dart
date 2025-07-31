import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_app/core/app_theme.dart';
import 'package:garage_app/presentation/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';


class MyApp extends StatefulWidget {
  const MyApp._internal();

  static MyApp instance = const MyApp._internal();

  @override
  State<MyApp> createState() => _MyAppState();

  factory MyApp() => instance;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Set your desired color here
      statusBarBrightness:
      Brightness.light, // You can also set the brightness (dark or light)
    ));

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: appTheme,
        );
      },
    );
  }
}
