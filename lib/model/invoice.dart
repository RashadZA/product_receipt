const String tableInvoices = 'invoices';

class InvoicesFields {

  static final List<String> values = [
    //add all file
    id, name, code, rate
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String rate = 'rate';
}

class Invoice {
  final int? id;
  final String name;
  final String code;
  final String rate;

  const Invoice({
    this.id,
    required this.name,
    required this.code,
    required this.rate,
  });

  Invoice copy({
    int? id,
    String? name,
    String? code,
    String? rate,
  }) =>
      Invoice(
        id: id ?? this.id,
        name:  name ?? this.name,
        code: code ?? this.code,
        rate: rate ?? this.rate,
      );
  static Invoice fromJson(Map<String, Object?> json) => Invoice(
    id: json[InvoicesFields.id] as int?,
    name: json[InvoicesFields.name] as String,
    code: json[InvoicesFields.code] as String,
    rate: json[InvoicesFields.rate] as String,
  );

  Map<String, Object?> toJson() => {
    InvoicesFields.id: id,
    InvoicesFields.name: name,
    InvoicesFields.code: code,
    InvoicesFields.rate: rate,

  };
}
