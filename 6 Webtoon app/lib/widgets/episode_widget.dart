import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  //컨테이너 tap하는 것을 감지
  onButtonTap() async {
    // final url = Uri.parse("https://google.com");
    // await launchUrl(url);
    //밑에 줄과 같음
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //탭하면 해당 함수 실행
      onTap: onButtonTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10), //버튼 사이 공간
        decoration: BoxDecoration(
          //버튼 디자인
          color: Colors.white,
          //테두리 설정
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.green.shade900,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //한쪽에 text, 한쪽에 icon 표시하기 위해 Row 사용
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  episode.title,
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontSize: 16,
                  ),
                ),
              ),

              // Text(
              //   episode.title,
              //   style: const TextStyle(
              //     color: Colors.green, //Expanded로 감싸야 shade400 사용가능
              //     fontSize: 16,
              //   ),
              // ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.green.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
