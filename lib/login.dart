import 'package:flutter/material.dart';
import 'package:sandori_test/start.dart';
import 'package:sandori_test/signup.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Map<String, TextEditingController> controllers = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  final List<Map<String, dynamic>> fields = [
    {
      'label': '아이디',
      'key': 'username',
      'obscure': false,
    },
    {
      'label': '비밀번호',
      'key': 'password',
      'obscure': true,
    },
  ];
  @override
  dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 60),

                  /// 상단 이미지와 텍스트
                  _Top(),

                  ///중단, 소셜 로그인
                  _Middle(
                    onGooglePressed: googleLogin,
                    onApplePressed: appleLogin,
                    onKakaoPressed: kakaoLogin,
                  ),
                  const OrDivider(), /// 또는 글자 추가

                  ///하단, 회원 아이디로 로그인
                  _Bottom(
                    textTheme: Theme.of(context).textTheme,
                    onPressed: login,
                    onSignupPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage(title: ''),),
                      );
                    },
                    controllers: controllers,
                    fields: fields,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  ///카카오 로그인 구동
  void kakaoLogin() {
    print('카카오로그인');
  }
  ///구글 로그인 구동
  void googleLogin(){
    print('구글로그인');
  }
  ///애플 로그인 구동
  void appleLogin() {
    print('애플로그인');
  }

  /// 로그인 구동
  void login() {
  print('아이디로 로그인 시도');
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.displayMedium;
    final largeText = Theme.of(context).textTheme.displayLarge;
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    final padding = SizedBox(height: 10);
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/sandori ver1.png', width: 130, height: 130),
        ),
        padding,
        Text('쉽게 로그인하고', style: mediumText?.copyWith(fontSize: 26)),
        padding,
        Text('다양한 서비스를 이용해보세요', style: titleLarge?.copyWith(fontSize: 26)),
        SizedBox(height: 30),
      ],
    );
  }
}

class _Middle extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onKakaoPressed;
  const _Middle({
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onKakaoPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> outlinebutton = [
      {
        'Image': 'assets/google.png',
        'Text': 'Google 로 시작하기',
        'OnPressed': onGooglePressed,
      },
      {
        'Image': 'assets/apple.png',
        'Text': 'Apple 로 시작하기',
        'OnPressed': onApplePressed,
      },
    ];
    final mediumText = Theme.of(context).textTheme.displayMedium;
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0XFFFEE500),
            fixedSize: Size(400, 40),
            elevation: 0,
          ),
          onPressed: onKakaoPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/kakao.png',
                  width: 24,   // 원하는 너비
                  height: 24, ),
              ),
              Center(child: Text('카카오톡으로 시작하기',style: TextStyle(fontSize: 18, color: Colors.black))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:
            outlinebutton
                .map(
                  (item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(500, 40),
                  ),
                  onPressed: item['OnPressed'] as VoidCallback,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(item['Image'],
                          width: 40,   // 원하는 너비
                          height: 24,
                        ),
                      ),
                      Center(
                        child: Text(item['Text'], style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: const [
          Expanded(child: Divider(thickness: 1, color: Colors.grey)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("또는"),
          ),
          Expanded(child: Divider(thickness: 1, color: Colors.grey)),
        ],
      ),
    );
  }
}
class _Bottom extends StatelessWidget {
  final TextTheme textTheme;
  final VoidCallback onPressed; // 로그인 버튼
  final VoidCallback onSignupPressed; // 회원가입 버튼
  final Map<String, TextEditingController> controllers;
  final List<Map<String, dynamic>> fields;

  const _Bottom({
    required this.textTheme,
    required this.onPressed,
    required this.onSignupPressed,
    required this.controllers,
    required this.fields,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        children: [
          // 아이디 / 비밀번호 필드
          ...fields.map((field) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: controllers[field['key']]!,
              obscureText: field['obscure'],
              decoration: InputDecoration(
                labelText: field['label'],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF84C9DB), width: 2),
                ),
              ),
            ),
          )).toList(), // ← map 끝나고 toList() 필수!

          const SizedBox(height: 18),

          // 로그인 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF84C9DB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 148, vertical: 17),
                ),
                onPressed: onPressed,
                child: const Text(
                  '로그인하기',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 회원가입 안내
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('계정이 없으신가요? ', style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: onSignupPressed,
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF84C9DB),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}