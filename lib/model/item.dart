const String tableItems = 'item';

class ItemsFields {

  static final List<String> values = [
    //add all file
    id, name, code, rate
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String rate = 'rate';
}

class Item {
  final int? id;
  final String name;
  final String code;
  final String rate;

  const Item({
    this.id,
    required this.name,
    required this.code,
    required this.rate,
  });

  Item copy({
    int? id,
    String? name,
    String? code,
    String? rate,
  }) =>
      Item(
        id: id ?? this.id,
        name:  name ?? this.name,
        code: code ?? this.code,
        rate: rate ?? this.rate,
      );
  static Item fromJson(Map<String, Object?> json) => Item(
    id: json[ItemsFields.id] as int?,
    name: json[ItemsFields.name] as String,
    code: json[ItemsFields.code] as String,
    rate: json[ItemsFields.rate] as String,
  );

  Map<String, Object?> toJson() => {
    ItemsFields.id: id,
    ItemsFields.name: name,
    ItemsFields.code: code,
    ItemsFields.rate: rate,

  };
}
