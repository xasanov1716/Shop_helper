class ShopModelFields {
  static const String id = 'id';
  static const String code = 'code';
  static const String count = 'count';
  static const String name = 'name';

  static const String tableName = 'table_name';
}

class ShopModel {
  int? id;
  final String code;
  final int count;
  final String name;

  ShopModel({required this.code,required this.name, required this.count, this.id});

  ShopModel copyWith({String? code, int? count, int? id,String? name}) => ShopModel(
      code: code ?? this.code, count: count ?? this.count, id: id ?? this.id,name: name ?? this.name);

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
    name: json[ShopModelFields.name] ?? '',
  id: json[ShopModelFields.id] ?? 0,
      code: json[ShopModelFields.code] ?? '', count: json[ShopModelFields.count] ?? 1);

  Map<String, dynamic> toJson() => {
        ShopModelFields.count: count,
        ShopModelFields.code: code,
    ShopModelFields.name: name,
      };
}
