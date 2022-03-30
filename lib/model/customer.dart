const String tableCustomers = 'customers';

class CustomerFields {

  static final List<String> values = [
    //add all file
    id, name, number, email
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String number = 'number';
  static const String email = 'email';
}

class Customer {
  final int? id;
  final String name;
  final String number;
  final String email;

  const Customer({
    this.id,
    required this.name,
    required this.number,
    required this.email,
  });

  Customer copy({
    int? id,
    String? name,
    String? number,
    String? email,
  }) =>
      Customer(
        id: id ?? this.id,
        name:  name ?? this.name,
        number: number ?? this.number,
        email: email ?? this.email,
      );
  static Customer fromJson(Map<String, Object?> json) => Customer(
    id: json[CustomerFields.id] as int?,
    name: json[CustomerFields.name] as String,
    number: json[CustomerFields.number] as String,
    email: json[CustomerFields.email] as String,
  );

  Map<String, Object?> toJson() => {
    CustomerFields.id: id,
    CustomerFields.name: name,
    CustomerFields.number: number,
    CustomerFields.email: email,

  };
}
