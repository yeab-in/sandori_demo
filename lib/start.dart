import 'package:flutter/material.dart';
import 'package:sandori_test/login.dart';

/**
    시작하기 페이지 25.08.05
    시작하기 페이지 수저 25.08.08
 **/

class StartPage extends StatelessWidget {
const StartPage({super.key});

@override
Widget build(BuildContext context) {
final textTheme = Theme.of(context).textTheme;
return Scaffold(
backgroundColor: Colors.white, /// 배경색
/// UI 요소가 가려지는 것을 방지
body: SafeArea(
child: Center(
///중앙정렬
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

/// 상단
_Top(textTheme: textTheme),
paddingY(100),
///중단
Padding(padding: const EdgeInsets.all(20.0),child: _Middle()),
paddingY(70.0),

///하단
_Bottom(
textTheme: textTheme,
onPressed: () => _navigateToLogin(context),
),
],
),
),
),
);
}
///버튼 클릭시 동작함수
void _navigateToLogin(BuildContext context) {
Navigator.of(
context,
).push(MaterialPageRoute(builder: (BuildContext context) => Loginscreen()));
}
///패딩함수
Widget paddingY(double value)=> SizedBox(height: value);
}
///상단 텍스트
class _Top extends StatelessWidget {
final TextTheme textTheme;
  const _Top({
required this.textTheme,
super.key});

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    final Large = Theme.of(context).textTheme.displayLarge;
    return Column(
children: [
  Text('새롭게 돌아온 산돌이',
textAlign: TextAlign.center,
style: Large?.copyWith(fontSize: 30),
),

Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
child: Text(
'여러분의 학교 생활을 \n편하게 만들어드릴게요',
style: textTheme.displayMedium?.copyWith(
fontSize: 18,
color: Colors.grey,
),
),
),
],
);
  }
}

///중단 이미지
class _Middle extends StatelessWidget {
  const _Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
    alignment: Alignment(0,0),
child: Stack(
  alignment: Alignment.center,
  children: [
  SizedBox(
  width: 150,
  height: 150,
  child: Image.asset('assets/sandori ver1.png'),
),
    SizedBox(
      width: 100,
      height: 100,
        child: CustomPaint(
          painter: CirclePainter([
            {'x': 150.0, 'y': -50.0, 'radius': 20.0, 'color': Color(0x804EA6AA)},
            {'x': 220.0, 'y': 20.0, 'radius': 30.0, 'color': Color(0xFFD9D9D9)},
            {'x': 200.0, 'y': 65.0, 'radius': 30.0, 'color': Color(0x804EA6AA)},
            {'x': -27.0, 'y': 190.0, 'radius': 30.0, 'color': Color(0x80FFE880)},
            {'x': 15.0, 'y': 220.0, 'radius': 30.0, 'color': Color(0x804EA6AA)},
            {'x': -90.0, 'y': 120.0, 'radius': 20.0, 'color': Color(0x80FFE880)},
          ]),
        ),
      ),
    ],
    ),
    );
  }
}
class CirclePainter extends CustomPainter {
  final List<Map<String, dynamic>> circles;

  CirclePainter(this.circles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var circle in circles) {
      final paint = Paint()
        ..color = circle['color'] as Color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(circle['x'] as double, circle['y'] as double),
        circle['radius'] as double,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


///하단 버튼
class _Bottom extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onPressed;
  const _Bottom({
required this.textTheme,
required this.onPressed,
super.key,
});

  @override
  Widget build(BuildContext context) {
    final baseButtonStyle = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    );
    return  Padding(    // 여기서 외부 여백 주기
        padding: const EdgeInsets.only(top: 80.0), // 위아래 20씩 여백
    child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.center,

children: [
  ElevatedButton(style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF84C9DB),
shape: baseButtonStyle,
padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
),
onPressed: onPressed,child: SizedBox(
    width: 100, // 글자 영역 넓이 고정
    child: Text(
    '시작하기',
    style: const TextStyle(fontSize: 20, color: Colors.black),
    textAlign: TextAlign.center,
    ),
    ),
  ),
],
    ),
);
  }
}
