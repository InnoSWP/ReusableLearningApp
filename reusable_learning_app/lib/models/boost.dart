class Boost {

  String? imageUrl;
  String? name;
  String? description;
  int? price;
  int? id;

  Boost.fromMap(dynamic json) {
    id = json["id"];
    imageUrl = json["image_url"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
  }
}
