class Province {
  final int id;
  final String nameTh;
  final String nameEn;

  Province({
    required this.id,
    required this.nameTh,
    required this.nameEn,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      nameTh: json['name_th'],
      nameEn: json['name_en'],
    );
  }

  List<Province> fromJsonList(List list) {
    return list.map((item) => Province.fromJson(item)).toList();
  }

  String getNameTh() {
    return nameTh;
  }
}
