import 'package:flutter/material.dart';
import 'package:sandori_test/start.dart';
import 'splash_screen.dart'; /// 스플래시 코드 페이지 연동
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: Splash(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandori Demo',
      theme: ThemeData(
        // 글꼴
       fontFamily: 'Kurb',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            //글자 두께
            fontWeight: FontWeight.w700, /// 배너 혹은 헤더 글씨
            fontSize: 30,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 10,
          )
        ),
      ),
      );
    }
}
