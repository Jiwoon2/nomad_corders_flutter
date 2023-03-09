import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  //클래스 안에 Future를 넣었기 때문에 const HomeScreen(~)를 사용할 수 없음
  HomeScreen({Key? key}) : super(key: key);
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        //글씨색

        title: Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons, //future데이터를 기다림
        builder: (context, snapshot) {
          //future가 완료되어 데이터가 존재하면
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  //나머지 부분을 채움
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(), //로딩 아이콘
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        //인덱스 0,1,2..로 접근
        print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40, //사이에 넣는 값
      ),
    );
  }
}
