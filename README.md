
# 삼겹살 반찬 선택 앱
![image](https://github.com/incheonQ/samgyeopsal/삼겹살_먹을_때_3가지만_골라야_한다면.jpg)

이 앱은 사용자가 삼겹살과 잘 어울리는 반찬을 선택하여 그 사람의 성향을 분석하는 Flutter 애플리케이션입니다. 

사용자는 최대 3가지 반찬을 선택할 수 있으며, 선택한 반찬에 따라 성향 분석 결과를 제공합니다.

## 사용 예시
![image](https://github.com/user-attachments/assets/0b763dc3-3bb4-4a78-be56-f86a7b724343)
![image](https://github.com/user-attachments/assets/546650a6-c324-4fa0-9c9b-769c3aca782c)


## 파일 설명

### `lib/main.dart`
- 앱의 진입점입니다.
- 환경 변수를 로드하고, `FoodSelectionScreen`을 홈 화면으로 설정합니다.

### `lib/food_selection_screen.dart`
- 사용자가 반찬을 선택할 수 있는 화면을 제공합니다.
- 선택된 반찬은 `Set`으로 저장되며, 최대 3가지까지 선택할 수 있습니다.
- 반찬을 선택한 후 "성향 분석하기" 버튼을 클릭하면 `ResultScreen`으로 이동하여 성향 분석 결과를 확인할 수 있습니다.

### `lib/result_screen.dart`
- 선택된 반찬을 기반으로 성향 분석 결과를 보여주는 화면입니다.
- OpenAI API를 사용하여 성향 분석을 수행하며, 결과는 텍스트로 표시됩니다.
- 로딩 중에는 `CircularProgressIndicator`가 표시됩니다.

## 사용 방법
1. 앱을 실행하면 반찬 선택 화면이 나타납니다.
2. 원하는 반찬을 클릭하여 선택합니다.
3. 3가지 반찬을 선택한 후 "성향 분석하기" 버튼을 클릭합니다.
4. 성향 분석 결과가 나타나는 화면으로 이동합니다.

## 환경 설정
- `.env` 파일에 OpenAI API 키를 추가해야 합니다.
- `flutter_dotenv` 패키지를 사용하여 환경 변수를 로드합니다.

## 의존성
- `flutter`
- `http`
- `flutter_dotenv`
