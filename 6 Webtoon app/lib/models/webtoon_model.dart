class WebtoonModel {
  final String title, thumb, id;

  //named constructor- 이름이 있는 생성자
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
