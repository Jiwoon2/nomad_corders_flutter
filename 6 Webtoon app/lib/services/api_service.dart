import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); //이 부분이 완전히 처리되길 원함-> 비동기식 필요 await

    if (response.statusCode == 200) {
      //요청 성공 코드
      final List<dynamic> webtoons =
          jsonDecode(response.body); //string을 json으로 디코딩
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon); //생성자에게 넘겨줌
        webtoonInstances.add(instance);
      }
      //print(webtoonInstances);
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body); //response.body를 json으로 변화
      return WebtoonDetailModel.fromJson(webtoon); //생성자롤 전달
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];

    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body); //response.body를 json으로 변화
      for (var episode in episodes){
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
