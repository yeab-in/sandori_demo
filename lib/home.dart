import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _Top(), // 상단
            const SizedBox(height: 16),
            _Middle(), // 가운데 카드 3개
            const SizedBox(height: 20),
            Expanded(child: _Grid()), // 하단 그리드
          ],
        ),
      ),
      bottomNavigationBar: const _Bottom(), // 하단 네비게이션
    );
  }
}

/// Top
class _Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Image.asset(
                  'assets/sandori ver1.png',
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "2025년 8월 26일",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "오늘도 맛있는 하루 되세요!",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.notifications_none, size: 34),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }
}

/// Middle(상단 카드 3개)
class _Middle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          _Card("학교→정왕역", Icons.directions_bus, "다음 셔틀\n12:35\n5분 뒤 도착"),
          SizedBox(width: 12),
          _Card("E동 식당", Icons.restaurant, "제육볶음\n요구르트\n미역국"),
          SizedBox(width: 12),
          _Card("지금\n빈 강의실", Icons.menu_book, "E동 305\nE동 407"),
        ],
      ),
    );
  }
}

/// Grid 영역 (하단 4개 카드)
class _Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          SizedBox(
              width: 70,
              height: 70,
              child: _Card("버스 조회", Icons.directions_bus, "")),
          SizedBox(
              width: 70,
              height: 70,
              child: _Card("학식 조회", Icons.restaurant_menu, "")),
          SizedBox(
              width: 70,
              height: 70,
              child: _Card("빈 강의실 조회", Icons.meeting_room, "")),
          SizedBox(
              width: 70,
              height: 70,
              child: _Card("공지사항", Icons.account_balance, "")),
        ],
      ),
    );
  }
}

///  BottomNavigationBar
class _Bottom extends StatefulWidget {
  const _Bottom();
  @override
  State<_Bottom> createState() => _BottomState();
}

class _BottomState extends State<_Bottom> {
  int _currentIndex = 1; // 홈 기본 선택

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xBE418C8F), // 선택된 아이템 색
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "지도"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "MY PAGE"),
      ],
    );
  }
}

/// 공통 카드 위젯
class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const _Card(this.title, this.icon, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.grey[800]),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          if (content.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ]
        ],
      ),
    );
  }
}
