import 'package:flutter/material.dart';
import 'package:fun/result_screen.dart';

class FoodSelectionScreen extends StatefulWidget {
  @override
  _FoodSelectionScreenState createState() => _FoodSelectionScreenState();
}

class _FoodSelectionScreenState extends State<FoodSelectionScreen> {
  // 선택된 음식을 저장하는 Set
  final Set<String> selectedFoods = {};

  // 음식 데이터 리스트
  final List<Map<String, String>> foods = [
    {'name': '김치', 'image': 'assets/김치.jpg'},
    {'name': '소주', 'image': 'assets/소주.jpg'},
    {'name': '된장찌개', 'image': 'assets/된장찌개.jpg'},
    {'name': '계란찜', 'image': 'assets/계란찜.jpg'},
    {'name': '마늘', 'image': 'assets/마늘.jpg'},
    {'name': '공기밥', 'image': 'assets/공기밥.jpg'},
    {'name': '파절이', 'image': 'assets/파절이.jpg'},
    {'name': '김치찌개', 'image': 'assets/김치찌개.jpg'},
    {'name': '양파절임', 'image': 'assets/양파절임.jpg'},
    {'name': '쌈채소', 'image': 'assets/쌈채소.jpg'},
    {'name': '쌈장', 'image': 'assets/쌈장.jpg'},
    {'name': '콩나물', 'image': 'assets/콩나물.jpg'},
    {'name': '버섯', 'image': 'assets/버섯.jpg'},
    {'name': '비빔면', 'image': 'assets/비빔면.jpg'},
    {'name': '냉면', 'image': 'assets/냉면.jpg'},
    {'name': '소금', 'image': 'assets/소금.jpg'},
    {'name': '미나리', 'image': 'assets/미나리.jpg'},
    {'name': '부추겉절이', 'image': 'assets/부추겉절이.jpg'},
    {'name': '와사비', 'image': 'assets/와사비.jpg'},
    {'name': '기름장', 'image': 'assets/기름장.jpg'},
    {'name': '볶음밥', 'image': 'assets/볶음밥.jpg'},
    {'name': '쌈무', 'image': 'assets/쌈무.jpg'},
    {'name': '명이나물', 'image': 'assets/명이나물.jpg'},
    {'name': '고추장', 'image': 'assets/고추장.jpg'},
    {'name': '음료수', 'image': 'assets/음료수.jpg'},
  ];

  void toggleFood(String food) {
    setState(() {
      if (selectedFoods.contains(food)) {
        selectedFoods.remove(food);
      } else if (selectedFoods.length < 3) {
        selectedFoods.add(food);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('삼겹살 반찬 선택')),
      body: Container(
        width: 600,
        height: 600,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                ),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  final isSelected = selectedFoods.contains(food['name']);

                  return GestureDetector(
                    onTap: () => toggleFood(food['name']!),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              food['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(food['name']!),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: selectedFoods.length == 3
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                              selectedFoods: selectedFoods.toList()),
                        ),
                      )
                  : null,
              child: Text('성향 분석하기'),
            ),
          ],
        ),
      ),
    );
  }
}
