/**
    로그인 화면 25.08.05
 **/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 상단
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              toolbarHeight: 280,
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 140,
                      child: Image.asset('assets/logo.png'),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '쉽게 로그인하고 ${widget.title}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '다양한 서비스를 이용해보세요 ${widget.title}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),

      /// BODY
      body: Stack(
        children: [
          /// 카카오톡 로그인 버튼
          Positioned(
            left: 32,
            top: 0,
            child: GestureDetector(
              onTap: () {
                print("카카오 버튼 클릭됨");
              },
              child: Container(
                width: 350,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE867),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/kakao.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '카카오톡으로 시작하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 구글 로그인 버튼
          Positioned(
            left: 32,
            top: 80,
            child: GestureDetector(
              onTap: () {
                print("구글 버튼 클릭됨");
              },
              child: Container(
                width: 350,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/google.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Google로 시작하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 애플 로그인 버튼
          Positioned(
            left: 32,
            top: 160,
            child: GestureDetector(
              onTap: () {
                print("애플 버튼 클릭됨");
              },
              child: Container(
                width: 350,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/apple.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Apple로 시작하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 구분선
          Positioned(
            left: 30,
            top: 230,
            right: 30,
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                    endIndent: 10,
                  ),
                ),
                const Text(
                  '또는',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                    indent: 10,
                  ),
                ),
              ],
            ),
          ),

          /// 아이디 입력
          Positioned(
            top: 253,
            left: 40,
            right: 40,
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),

          /// 비밀번호 입력
          Positioned(
            top: 312,
            left: 40,
            right: 40,
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),

          /// 로그인 버튼
          Positioned(
            left: 20,
            right: 20,
            bottom: 85,
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  print("로그인하기 클릭됨");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xCF4EA6AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: const Text(
                  '로그인하기',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          /// 회원가입 안내 문구
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '계정이 없으신가요?',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: ' 회원가입',
                    style: const TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("회원가입 클릭됨");
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
