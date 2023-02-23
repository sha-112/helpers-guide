class Location {
  Location({required this.name, required this.details, required this.link});
  String name;
  String details;
  String link;

  Location.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        details = json['details'],
        link = json['link'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'details': details,
    'link': link,
  };

}