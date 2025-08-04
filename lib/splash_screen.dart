/**
 스플래시 화면 제작 페이지 25.08.04
 **/
import 'package:flutter/material.dart';

/// 스플래시 화면 구성
class Splash extends StatefulWidget { /// StatefulWidget : 일정시간 후 페이지 넘어가게 도움
  const Splash ({Key? key}) : super(key:key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: Container(
          /// width, height 설정 -> 화면 비율에 맞춰짐
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(

            /// 배경 그라데이션 색으로 설정
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF74C0C4), //하늘 색
                Color(0xFFB7D96A), //연두 색
              ],
            ),
          ),
         /// 행렬 설정 -> 로고의 위치 구제적 지정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 200,),
              const SizedBox(height: 100,),
            ],
          ),
        ),
    );
  }
}