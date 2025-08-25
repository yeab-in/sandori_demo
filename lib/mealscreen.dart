import 'package:flutter/material.dart';
import 'package:sandori_test/repository/meals.dart'; // meal.dart import

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  DateTime _currentMonday = _findMonday(DateTime.now());
  String _selectedMeal = "아침";
  DateTime _selectedDate = DateTime.now();

  static DateTime _findMonday(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));

  void _changeWeek(int offset) {
    setState(() {
      _currentMonday = _currentMonday.add(Duration(days: 7 * offset));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1️⃣ 상단 고정 영역
          _Top(
            currentMonday: _currentMonday,
            selectedMeal: _selectedMeal,
            selectedDate: _selectedDate,
            onMealChanged: (meal) => setState(() => _selectedMeal = meal),
            onWeekChanged: _changeWeek,
            onDateChanged: (date) => setState(() => _selectedDate = date),
          ),

          // 2️⃣ 식단 카드 스크롤 영역
          Expanded(
            child: Middle(
              weekday: _selectedDate.weekday - 1,
              mealType: _selectedMeal,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- 상단 캘린더 + 아침/점심/저녁 -----------------
class _Top extends StatelessWidget {
  final DateTime currentMonday;
  final String selectedMeal;
  final DateTime selectedDate;
  final Function(String) onMealChanged;
  final Function(int) onWeekChanged;
  final Function(DateTime) onDateChanged;

  _Top({
    super.key,
    required this.currentMonday,
    required this.selectedMeal,
    required this.selectedDate,
    required this.onMealChanged,
    required this.onWeekChanged,
    required this.onDateChanged,
  });

  final List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates =
    List.generate(7, (index) => currentMonday.add(Duration(days: index)));
    DateTime today = DateTime.now();

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // 로고
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'SAN',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      color: Color(0xBE3F8B8E),
                    ),
                  ),
                  TextSpan(
                    text: 'DORI',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 월 표시 + 화살표
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => onWeekChanged(-1),
                ),
                Text(
                  "${currentMonday.year}. ${currentMonday.month}.",
                  style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => onWeekChanged(1),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 요일 + 날짜
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekDates.map((day) {
                  bool isToday = day.day == today.day &&
                      day.month == today.month &&
                      day.year == today.year;
                  bool isSelected = selectedDate.day == day.day &&
                      selectedDate.month == day.month &&
                      selectedDate.year == day.year;

                  Color textColor = day.weekday == DateTime.saturday
                      ? Colors.blue
                      : day.weekday == DateTime.sunday
                      ? Colors.red
                      : Colors.black;

                  return GestureDetector(
                    onTap: () => onDateChanged(day),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekDays[day.weekday - 1],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? const Color(0xBE65A4A8)
                                : (isToday
                                ? Colors.grey.shade300
                                : Colors.transparent),
                          ),
                          child: Text(
                            "${day.day}",
                            style: TextStyle(
                              fontSize: 20,
                              color: isSelected
                                  ? Colors.white
                                  : (isToday ? Colors.black : textColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 아침/점심/저녁 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["아침", "점심", "저녁"].map((meal) {
                bool isSelected = selectedMeal == meal;
                return GestureDetector(
                  onTap: () => onMealChanged(meal),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        meal,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 100,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xBE65A4A8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
/// ----------------- 식단 카드 (최종 버전) -----------------
class Middle extends StatelessWidget {
  final int weekday;
  final String mealType;

  const Middle({super.key, required this.weekday, required this.mealType});

  // 16글자마다 줄바꿈
  String wrapText15(String text) {
    const int limit = 15;
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % limit == 0 && i != text.length - 1) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final meals = weeklyMeals[weekday] ?? [];
    final filteredMeals =
    meals.where((meal) => meal.type == mealType).toList();

    if (filteredMeals.isEmpty) {
      return const Center(child: Text("선택된 식단이 없습니다."));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: filteredMeals.map((meal) {
          return Card(
            color: const Color(0xFFFFF9F0),
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            shadowColor: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단 헤더 (식당명 + 위치)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(meal.cafeteria,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text(meal.location,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),

                  // 메뉴 + 가격
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 메뉴 텍스트 (왼쪽 정렬, 16글자마다 줄바꿈)
                      Expanded(
                        child: Text(
                          wrapText15(meal.menu.join(" + ")),
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      const SizedBox(width: 20),

                      // 가격: 오른쪽, 메뉴 높이 기준 약간 아래
                      Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          meal.price,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}