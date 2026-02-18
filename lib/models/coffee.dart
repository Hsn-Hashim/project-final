class Coffee {
  String? image;
  String? name;
  double? price;

  Coffee({this.image, this.name, this.price});

  Coffee.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}