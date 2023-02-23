class UniversityActivity {
  UniversityActivity({required this.image, required this.about, required this.link});
  String image;
  String about;
  String link;

  UniversityActivity.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'],
        about = json['about'],
        link = json['link'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'image': image,
    'about': about,
    'link': link,
  };

}