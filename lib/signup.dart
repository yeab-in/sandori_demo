import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool _agree1 = false;
  bool _agree2 = false;
  bool _agree3 = false;
  bool _agree4 = false;

  /// 아이디 입력 함수
  void _checkIdDuplicate() {
    final id = _idController.text.trim();
    if (id.isEmpty) {
      _showMessage('아이디를 입력하세요.');
      return;
    }
    _showMessage('아이디 "$id" 는 사용 가능합니다.');
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  //회원가입 진행시 필요한 함수
  void _signup() {
    final name = _nameController.text.trim();
    final id = _idController.text.trim();
    final pw = _pwController.text;
    final pwConfirm = _pwConfirmController.text;

    if (name.isEmpty || id.isEmpty || pw.isEmpty || pwConfirm.isEmpty) {
      _showMessage('모든 항목을 입력하세요.');
      return;
    }
    if (pw != pwConfirm) {
      _showMessage('비밀번호가 일치하지 않습니다.');
      return;
    }
    if (!(_agree1 && _agree2 )) {
      _showMessage('필수 이용약관에 동의해야 합니다.');
      return;
    }

    _showMessage('회원가입 성공! 로그인 페이지로 이동합니다.');
    Navigator.pop(context); // 로그인 페이지로 돌아가기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 상단
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      ///MIDDLE
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16), // 전체 패딩
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 회원가입 제목
                Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // 이름 입력칸
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '이름',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                /// 아이디 입력 + 중복확인
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _checkIdDuplicate,
                      child: Text('중복확인'),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                /// 비밀번호 입력칸
                TextField(
                  controller: _pwController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                /// 비밀번호 확인 입력칸
                TextField(
                  controller: _pwConfirmController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: '비밀번호 확인',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),

                /// 하단
                /// 이용약관 제목
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
                        '이용약관',
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
                SizedBox(height: 20),


                /// 체크박스
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4), // 위아래 여백 줄이기
                  value: _agree1,
                  onChanged: (v) => setState(() => _agree1 = v ?? false),
                  title: Text('이용약관 동의 (필수)'),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4), // 위아래 여백 줄이기
                  value: _agree2,
                  onChanged: (v) => setState(() => _agree2 = v ?? false),
                  title: Text('개인정보 수집 동의 (필수)'),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4), // 위아래 여백 줄이기
                  value: _agree3,
                  onChanged: (v) => setState(() => _agree3 = v ?? false),
                  title: Text('개인정보 수집 동의 (선택)'),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4), // 위아래 여백 줄이기
                  value: _agree4,
                  onChanged: (v) => setState(() => _agree4 = v ?? false),
                  title: Text('혜택, 알람 정보 수신 동의 (선택)'),
                ),

                SizedBox(height: 50),

                /// 회원가입 버튼
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xCF4EA6AA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      '회원가입하기',
                      style:
                      TextStyle(fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
