import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons(); //3- 데이터가 도착안했으므로 다음순서인 build 실행
    isLoading = false; //6- 3에서 데이터가 완전히 전달되어 실행
    setState(() {}); //7- setState를 호출하여 build 메소드 자동 호출. re-render
  }

  @override
  void initState() {
    super.initState(); //실행순서 1
    waitForWebToons(); //2
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons); //4, 8-자동 호출되어 변화된 데이터 출력
    print(isLoading); //5, 9

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,//글씨색


        title: Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
