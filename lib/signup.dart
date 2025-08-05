import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key? key, required this.title});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 상단 - 회원가입
      /// body - 아이디, 중복확인, 비밀번호/확인
      /// 하단- 이용약관, 동의, 회원가입 완료
    );
  }
}
