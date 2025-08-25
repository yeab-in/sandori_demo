class Meal {
  final String cafeteria;
  final String location;
  final List<String> menu;
  final String price;
  final String type; // "아침", "점심", "저녁"

  Meal({
    required this.cafeteria,
    required this.location,
    required this.menu,
    required this.price,
    required this.type,
  });
}

// ----------------- 샘플 식단 데이터 -----------------
final Map<int, List<Meal>> weeklyMeals = {
  0: [ // 월요일
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "아침",
    ),
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "아침",
    ),
    Meal(
      cafeteria: "E동 식당",
      location: "E동 건물 1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "아침",
    ),
    Meal(
      cafeteria: "미가 식당",
      location: "미가 건물 5층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "아침",
    ),
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "점심",
    ),
    Meal(
      cafeteria: "E동 식당",
      location: "E동 건물 1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "점심",
    ),
    Meal(
      cafeteria: "미가 식당",
      location: "미가 건물 5층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "점심",
    ),
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "저녁",
    ),
    Meal(
      cafeteria: "E동 식당",
      location: "E동 건물 1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "저녁",
    ),
    Meal(
      cafeteria: "미가 식당",
      location: "미가 건물 5층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "저녁",
    ),
    Meal(
      cafeteria: "미가 식당",
      location: "미가 건물 5층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "저녁",
    ),
  ],
  1: [ // 화요일
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "아침",
    ),
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "점심",
    ),
    Meal(
      cafeteria: "TIP 식당",
      location: "TIP 건물 지하1층",
      menu: ["김밥", "라면", "치즈", "닭강정","고구마맛우유","아이셔같은아이스크림"],
      price: "3,000원",
      type: "저녁",
    ),
  ],
  // 나머지 요일도 같은 형식으로 추가 가능
};
