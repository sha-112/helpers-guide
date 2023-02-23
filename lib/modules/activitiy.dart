class Activity {
  Activity({required this.image, required this.link});
  String image;
  String link;

  Activity.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'],
        link = json['link'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'image': image,
    'link': link,
  };

}