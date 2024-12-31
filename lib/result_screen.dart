import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResultScreen extends StatefulWidget {
  final List<String> selectedFoods;

  ResultScreen({required this.selectedFoods});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? personalityResult;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPersonalityAnalysis();
  }

  Future<void> getPersonalityAnalysis() async {
    setState(() => isLoading = true);

    final apiKey = dotenv.env['OPENAI_API_KEY'];
    const url = 'https://api.openai.com/v1/chat/completions';

    final prompt = '''
삼겹살을 먹을 때 선택한 반찬 3가지로 그 사람의 성향을 파악하기

삼겹살과 잘 어울린다고 알려진 25가지 반찬 중에서 3가지를 선택하면, 그 사람의 성향을 분석할 수 있습니다.

반찬 목록:
김치, 소주, 된장찌개, 계란찜, 마늘, 공기밥, 파절이, 김치찌개, 양파절임, 쌈채소, 쌈장, 콩나물, 버섯, 비빔면, 냉면, 소금, 미나리, 부추겉절이, 와사비, 기름장, 볶음밥, 쌈무, 명이나물, 고추장, 음료수

예시 질문:
"${widget.selectedFoods.join(', ')}"을(를) 선택했다면, 이 사람은 어떤 성격이나 성향을 가지고 있을 가능성이 높을까?

참고사항:

반찬 선택은 성격, 취향, 혹은 특정 상황에 따라 달라질 수 있으니, 각 반찬의 이미지와 상징성을 반영해 분석해 주세요.
유머러스하거나 창의적인 해석도 환영합니다!
''';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt},
          ],
          "max_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          personalityResult = data['choices'][0]['message']['content'];
          isLoading = false;
        });
      } else {
        setState(() {
          personalityResult = "Error: ${response.statusCode}\n${response.body}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        personalityResult = "Failed to connect: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('성향 분석 결과')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('선택하신 반찬:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...widget.selectedFoods.map((food) => Text('- $food')),
            SizedBox(height: 24),
            Text('당신의 성향:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (isLoading)
              CircularProgressIndicator()
            else if (personalityResult != null)
              Text(personalityResult!),
          ],
        ),
      ),
    );
  }
}
