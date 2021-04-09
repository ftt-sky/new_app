
class SplashAdModel {

  String title;
  String content;
  String url;
  String imgUrl;

  SplashAdModel({this.title, this.content, this.url, this.imgUrl});

  SplashAdModel.fromJson(Map<String, dynamic> json)
  : title = json['title'],
  content = json['content'],
  url = json['url'],
  imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
    'title':title,
    'content':content,
    'url':url,
    'imgUrl':imgUrl
  };


}
