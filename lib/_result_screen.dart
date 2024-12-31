import 'package:flutter/material.dart';

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

    try {
      final response =
          """삼겹살을 먹을 때 마늘, 공기밥, 쌈채소를 선택했다면, 이 사람의 성향은 대체로 기본에 충실하고 실용적인 스타일이라고 볼 수 있어요. 각각의 선택을 기반으로 성향을 분석해보면:

마늘: 풍미를 더하고 삼겹살의 느끼함을 잡아주는 마늘을 선택한 것은 음식의 밸런스를 중요하게 생각하고, 맛을 세심하게 신경 쓰는 사람임을 보여줍니다. 자극적이거나 복잡한 맛보다는 기본적인 조화를 선호할 가능성이 높습니다.

공기밥: 밥을 선택한 것은 배부름과 안정감을 중시한다는 뜻이에요. 이는 현실적이고 실용적인 성격을 가진 사람일 가능성을 시사합니다. 음식을 먹을 때 포만감과 함께 전통적인 식사 형식을 선호한다고 볼 수 있습니다.

쌈채소: 쌈채소를 선택한 것은 건강을 생각하거나, 삼겹살의 맛을 신선한 채소와 조화롭게 즐기고자 하는 사람이라는 점을 나타냅니다. 전통적인 방식을 좋아하면서도 균형과 조화를 추구하는 성향을 보여줍니다.

종합적으로:
이 사람은 전통적이고 안정적인 가치관을 가진 동시에, 균형과 기본을 중시하는 현실적인 사람일 가능성이 높습니다. 자극적이거나 복잡한 맛보다는 기본에 충실하면서도 조화를 이루는 것을 좋아하는 스타일로, 새로운 시도를 하기보다는 검증된 선택을 더 선호할 수 있습니다.""";
      setState(() {
        personalityResult = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        personalityResult = "분석 중 오류가 발생했습니다.";
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
