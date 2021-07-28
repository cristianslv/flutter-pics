class Pic {
  int id;
  String picStr;
  String title;
  String description;
  String lat;
  String long;
  int date;

  Pic({this.picStr, this.title, this.description, this.lat, this.long, this.date});

  Pic.fromMap(Map<String, dynamic> map) {
    this.id          = map['id'];
    this.picStr       = map['string'];
    this.title       = map['title'];
    this.description = map['description'];
    this.lat         = map['lat'];
    this.long        = map['long'];
    this.date        = map['date'];
  }

  @override
  String toString() {
    return "$id - $title";
  }
}