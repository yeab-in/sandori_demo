import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String passwordCheckText = '';

  final List<Map<String, dynamic>> signupFields = [
    {
      'header': '이름',
      'obscure': false,
      'showicon': false,
      'controller': TextEditingController(),
    },
    {
      'header': '아이디',
      'obscure': false,
      'showicon': false,
      'controller': TextEditingController(),
    },
    {
      'header': '비밀번호',
      'obscure': true,
      'showicon': true,
      'controller': TextEditingController(),
    },
    {
      'header': '비밀번호 확인',
      'obscure': true,
      'showicon': true,
      'controller': TextEditingController(),
    },
  ];

  final List<Map<String, dynamic>> agreeText = [
    {'title': '이용 약관 동의(필수)', 'checked': false},
    {'title': '개인정보 수집 동의(필수)', 'checked': false},
    {'title': '개인정보 수집 동의(선택)', 'checked': false},
    {'title': '혜택/알림 정보 수신 동의(선택)', 'checked': false},
  ];

  @override
  void initState() {
    super.initState();
    signupFields[2]['controller'].addListener(_checkPasswordMatch);
    signupFields[3]['controller'].addListener(_checkPasswordMatch);
  }

  void _checkPasswordMatch() {
    final pw = signupFields[2]['controller'].text;
    final res = signupFields[3]['controller'].text;

    setState(() {
      if (res.isEmpty) {
        passwordCheckText = '비밀번호가 다릅니다';
      } else if (pw == res) {
        passwordCheckText = '비밀번호가 일치합니다!';
      } else {
        passwordCheckText = '비밀번호가 다릅니다';
      }
    });
  }

  /// 회원가입 함수
  void _signup() {
    final name = signupFields[0]['controller'].text.trim();
    final id = signupFields[1]['controller'].text.trim();
    final pw = signupFields[2]['controller'].text;
    final pwConfirm = signupFields[3]['controller'].text;

    if (name.isEmpty || id.isEmpty || pw.isEmpty || pwConfirm.isEmpty) {
      _showMessage('모든 항목을 입력하세요.');
      return;
    }
    if (pw != pwConfirm) {
      _showMessage('비밀번호가 일치하지 않습니다.');
      return;
    }
    if (!(agreeText[0]['checked'] && agreeText[1]['checked'])) {
      _showMessage('필수 이용약관에 동의해야 합니다.');
      return;
    }

    _showMessage('회원가입 성공! 로그인 페이지로 이동합니다.');
    Navigator.pop(context); // 로그인 페이지로 이동
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final line = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Row(
        children: const [
          Expanded(child: Divider(thickness: 1.5, color: Colors.grey)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('이용약관', style: TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Divider(thickness: 1.5, color: Colors.grey)),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  /// 상단
                  const _Top(),

                  /// 텍스트 입력 필드
                  _TextField(
                    signupFields: signupFields,
                    setStateCallback: setState,
                    passwordCheckText: passwordCheckText,
                  ),

                  /// 구분선
                  line,

                  /// 체크 박스
                  _CheckBox(agreeText: agreeText, setStateCallback: setState),
                  const SizedBox(height: 30),

                  /// 하단 버튼
                  _Bottom(onSignupPressed: _signup),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 상단 위젯
class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Text('회원가입', style: titleLarge?.copyWith(fontSize: 30)),
    );
  }
}

/// 텍스트 필드 위젯
class _TextField extends StatelessWidget {
  final List<Map<String, dynamic>> signupFields;
  final String passwordCheckText;
  final void Function(void Function()) setStateCallback;

  const _TextField({
    required this.signupFields,
    required this.setStateCallback,
    required this.passwordCheckText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: signupFields.asMap().entries.map((entry) {
        int index = entry.key;
        final item = entry.value;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 60,
                child: TextField(
                  controller: item['controller'],
                  obscureText: item['obscure'],
                  decoration: InputDecoration(
                    labelText: item['header'],

                    // 아이디 입력창일 때만 중복확인 버튼
                    suffixIcon: index == 1
                        ? TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("아이디 사용 가능")),
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text("중복확인"),
                    )
                        : item['showicon'] // 비밀번호 칸이면 눈 아이콘
                        ? IconButton(
                      onPressed: () {
                        setStateCallback(() {
                          signupFields[index]['obscure'] =
                          !signupFields[index]['obscure'];
                        });
                      },
                      icon: Icon(
                        item['obscure']
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                        : null,
                    suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                      const BorderSide(color: Color(0XFF00C4F9)),
                    ),
                  ),
                ),
              ),
            ),
            if (index == 3)
              Text(
                passwordCheckText,
                style: TextStyle(
                  color: passwordCheckText.contains('일치')
                      ? Colors.blueAccent
                      : Colors.red,
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}


/// 체크박스 위젯
class _CheckBox extends StatelessWidget {
  final List<Map<String, dynamic>> agreeText;
  final void Function(void Function()) setStateCallback;
  const _CheckBox({
    required this.agreeText,
    required this.setStateCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Column(
        children: agreeText.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['title'], style: mediumText),
              Checkbox(
                value: item['checked'],
                onChanged: (bool? value) {
                  setStateCallback(() {
                    agreeText[index]['checked'] = value!;
                  });
                },
                activeColor: Colors.green,
                checkColor: Colors.white,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// 하단 버튼 위젯
class _Bottom extends StatelessWidget {
  final VoidCallback onSignupPressed;
  const _Bottom({
    required this.onSignupPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediumText = Theme.of(context).textTheme.bodyMedium;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xCF4EA6AA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 120,
          vertical: 17,
        ),
      ),
      onPressed: onSignupPressed,
      child: Text(
        '회원가입하기',
        style: mediumText?.copyWith(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
