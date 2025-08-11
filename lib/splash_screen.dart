import 'package:flutter/material.dart';
import 'package:sandori_test/start.dart';

/// 스플래시 화면 구성
class Splash extends StatefulWidget { /// StatefulWidget : 일정시간 후 페이지 넘어가게 도움
  const Splash ({Key? key}) : super(key:key);
  @override
  _SplashState createState() => _SplashState();
}

/// 일정시간 뒤 시작 화면 페이지로 이동
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartPage( ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold (

      body: Center(
        child: Container(
          /// width, height 설정 -> 화면 비율에 맞춰짐
          width: double.infinity,
          height: double.infinity,
         color: Color(0xFF95E0F4),
          /// 행렬 설정 -> 로고의 위치 구제적 지정 (세로 방향 중앙)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 300,),
              Image.asset('assets/sandori version2.png', height: 225,),
            ],
          ),
        ),
      ),
    );
  }
}