/**
 시작하기 페이지 25.08.05
**/
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  /// 시작페이지임을 컴퓨터에 선언
  final String title;

  /// title 값 없이는 위젯 받지 못하는 문제 해결
  const StartPage ({Key? key, required this.title});


  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// 상단
      appBar: AppBar(
        toolbarHeight: 280,
        backgroundColor: Colors.white,
        title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('새롭게 돌아온 산돌이 ${widget.title}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            ),
            SizedBox(height: 15),
            Text('여러분의 학교 생활을 ${widget.title}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                )
            ),
            Text('편하게 만들어드릴게요 ${widget.title}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                )
            ),
          ],
        ),
      ),
      ),

      /// BODY
      body: Stack(
        children: [
          Center(
    child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            const SizedBox(height: 10),
        SizedBox(
          width: 400,
          height: 360,

        child: Stack(
          alignment: Alignment.center,
          children: [
            ///산돌이 로고
            Positioned(
              bottom: 100,
              left: 100,
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/logo.png', height: 300),
              ),
            ),


            /// 중앙
            /// 파란색 원
            Positioned(
              top: 20,
              left: 170,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4EA6AA),
                ),
              ),
            ),

            /// 오른쪽
            /// 회색 원
            Positioned(
              top: 80,
              left: 290,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xA8A1A0A0),
                ),
              ),
            ),

            /// 파란색 원
            Positioned(
              top: 110,
              left: 310,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xBB4EA6AA),
                ),
              ),
            ),

            /// 노란색 원
            Positioned(
              bottom: 60,
              left: 300,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFCFFDD4E),
                ),
              ),
            ),

            /// 왼쪽
            /// 파란색 원
            Positioned(
              bottom: 50,
              left: 50,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xBE4EA6AA),
                ),
              ),
            ),

            ///노란색원 (bottom)
            Positioned(
              bottom: 10,
              left: 78,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xCBFFDD4E),
                ),
              ),
            ),

            ///노란색원 (top)
            Positioned(
              top: 70,
              left: 38,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xAEFFE064),
                ),
              ),
            ),
          ],
        ),
        ),
        const SizedBox(height: 80),
        ],
      ),
      ),
      /// 하단
      /// 버튼

      const Spacer(),

    Positioned(
    left: 20,
    right: 20,
    bottom: 40,  // 하단에서 40px 위로 띄움
    child: SizedBox(
      height: 60, // 버튼 높이
      child: ElevatedButton(
        onPressed: () {
          print("시작하기 버튼 클릭");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xCF4EA6AA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
    child: const Text(
    '시작하기',
    style: TextStyle(
    fontSize: 25,
    color: Colors.white),
    ),
    ),
    ),
    ),
      ],
      ),
    );
  }
}
