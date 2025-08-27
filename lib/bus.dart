import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'dart:async';

/// 메인 페이지: 셔틀/일반버스/지하철 탭
class ShuttlePage extends StatefulWidget {
  const ShuttlePage({super.key});

  @override
  State<ShuttlePage> createState() => _ShuttlePageState();
}

class _ShuttlePageState extends State<ShuttlePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTab = "셔틀버스"; // 현재 선택된 탭

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // 탭 변경 시 선택 탭 업데이트
        _selectedTab = ["셔틀버스", "일반버스", "지하철"][_tabController.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            ///상단
            _Top(tabController: _tabController), // 상단 탭바
            ///중단
            const Middle(),                     // 셔틀버스 카드
            ///하단
            Expanded(child: _Bottom(selectedTab: _selectedTab)), // 하단 카드
          ],
        ),
      ),
    );
  }
}

/// Top 영역: 로고 + 탭바
class _Top extends StatelessWidget {
  final TabController tabController;
  const _Top({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {},
              ),
              Expanded(
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 18),
                      children: [
                        TextSpan(text: "SAN", style: TextStyle(color: Colors.teal)),
                        TextSpan(text: "DORI", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.0, color: Colors.teal),
              insets: EdgeInsets.symmetric(horizontal: 90.0),
            ),
            tabs: const [
              Tab(text: "셔틀버스"),
              Tab(text: "일반버스"),
              Tab(text: "지하철"),
            ],
          ),
        ],
      ),
    );
  }
}

/// Middle 영역: 셔틀버스 카드
class Middle extends StatefulWidget {
  const Middle({super.key});

  @override
  State<Middle> createState() => _MiddleState();
}

class _MiddleState extends State<Middle> {
  String start = "정왕역";
  String end = "학교";
  String shuttle = "1465번 셔틀";
  String time = "3분 뒤";

  // 선택 가능한 경로
  final List<Map<String, String>> routes = [
    {"start": "정왕역", "end": "학교", "shuttle": "1465번 셔틀", "time": "3분 뒤"},
    {"start": "학교", "end": "정왕역", "shuttle": "1466번 셔틀", "time": "5분 뒤"},
    {"start": "2캠퍼스", "end": "학교", "shuttle": "2캠퍼스 셔틀", "time": "7분 뒤"},
    {"start": "학교", "end": "2캠퍼스", "shuttle": "2캠퍼스 셔틀", "time": "6분 뒤"},
  ];

  // 수정 버튼 클릭 시 다이얼로그 띄우기
  void _showEditDialog() async {
    final selected = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("경로 선택"),
          children: routes.map((route) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, route),
              child: Text("${route['start']} ⇄ ${route['end']}"),
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        start = selected['start']!;
        end = selected['end']!;
        shuttle = selected['shuttle']!;
        time = selected['time']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 출발지 + 셔틀
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(start, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 6),
                      Text(shuttle, style: const TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  const Icon(Icons.compare_arrows, size: 28, color: Colors.black),
                  // 도착지 + 시간
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(end, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 6),
                      Text(time, style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: _showEditDialog,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("수정"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom 영역: 셔틀/일반버스/지하철
class _Bottom extends StatefulWidget {
  final String selectedTab;
  const _Bottom({super.key, required this.selectedTab});

  @override
  State<_Bottom> createState() => _BottomState();
}

class _BottomState extends State<_Bottom> {
  // 일반버스
  final List<Map<String, String>> buses = [
    {"number": "20-1", "time": "3분 뒤"},
    {"number": "33", "time": "5분 뒤"},
    {"number": "26-1", "time": "7분 뒤"},
  ];

  // 지하철
  final List<Map<String, String>> subways = [
    {"line": "수인분당선", "direction": "인천행", "time": "2분 뒤"},
    {"line": "4호선", "direction": "당고개행", "time": "5분 뒤"},
    {"line": "수인분당선", "direction": "왕십리행", "time": "7분 뒤"},
  ];

  // 애니메이션 진행률
  double progress = 0.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // 0~1 반복하는 애니메이션
    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      setState(() {
        progress += 0.02;
        if (progress > 1.0) progress = 0.0;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTab == "셔틀버스") {
      // 셔틀버스: 기존 지도
      final shuttleLocation = NLatLng(37.339649, 126.732365);
      return Card(
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: shuttleLocation,
                zoom: 16,
              ),
            ),
            onMapReady: (controller) {
              final marker = NMarker(
                id: "shuttle_marker",
                position: shuttleLocation,
                caption: const NOverlayCaption(text: "셔틀 탑승위치"),
              );
              controller.addOverlay(marker);
            },
          ),
        ),
      );
    } else if (widget.selectedTab == "일반버스") {
      // 일반버스 카드 + 이동 아이콘
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: buses.length,
        itemBuilder: (context, index) {
          final bus = buses[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("버스 ${bus['number']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("도착: ${bus['time']}", style: const TextStyle(fontSize: 14, color: Colors.red)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth - 30;
                        return Stack(
                          children: [
                            Positioned(
                              top: 12,
                              left: 0,
                              right: 0,
                              child: Container(height: 4, color: Colors.grey[300]),
                            ),
                            Positioned(
                              top: 0,
                              left: progress * maxWidth,
                              child: const Icon(Icons.directions_bus, color: Colors.teal, size: 30),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (widget.selectedTab == "지하철") {
      // 지하철 카드 + 이동 아이콘
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: subways.length,
        itemBuilder: (context, index) {
          final subway = subways[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${subway['line']} ${subway['direction']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("도착: ${subway['time']}", style: const TextStyle(fontSize: 14, color: Colors.red)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth - 30;
                        return Stack(
                          children: [
                            Positioned(
                              top: 12,
                              left: 0,
                              right: 0,
                              child: Container(height: 4, color: Colors.grey[300]),
                            ),
                            Positioned(
                              top: 0,
                              left: progress * maxWidth,
                              child: const Icon(Icons.train, color: Colors.red, size: 30),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // 안전장치: 알 수 없는 탭
      return const Center(child: Text("알 수 없는 탭"));
    }
  }
}
