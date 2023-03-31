class AppContact {
  String? id;
  String? name;
  String? number;
  String? categoryId;
  bool marked = false;

  AppContact({
    this.id,
    this.name,
    this.number,
    this.categoryId,
    this.marked = false,
  });

  AppContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    categoryId = json['category_id'];
    marked = json['marked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['category_id'] = categoryId;
    data['marked'] = marked;
    return data;
  }
}
