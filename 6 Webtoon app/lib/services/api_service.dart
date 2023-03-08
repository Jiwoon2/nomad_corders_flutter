import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); //이 부분이 완전히 처리되길 원함-> 비동기식 필요 await

    if (response.statusCode == 200) { //요청 성공 코드
      final List<dynamic> webtoons = jsonDecode(
          response.body); //string을 json으로 디코딩
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon); //생성자에게 넘겨줌
        webtoonInstances.add(instance);
      }
      print(webtoonInstances);
      return webtoonInstances;
    }
    throw Error();
  }
}


