const String tableInvoices = 'invoice';

class InvoiceFields {

  static final List<String> values = [
    //add all file
    id,
    time,
    customerName,
    itemName,
    itemQTY,
    itemRate,
    totalItem,
    totalQTY,
    totalRate
  ];
  static final String id = '_id';
  static final String time = 'time';
  static final String customerName = 'customerName';
  static final String itemName = 'itemNamer';
  static final String itemRate = 'itemRate';
  static final String itemQTY = 'itemQTY';
  static final String totalItem = 'totalItem';
  static final String totalQTY = 'totalQTY';
  static final String totalRate = 'totalRate';
}

class Invoice {
  final int? id;
  final DateTime createdTime;
  final String customerName;
  final String itemName;
  final String itemRate;
  final String itemQTY;
  final String totalItem;
  final String totalQTY;
  final String totalRate;


  const Invoice({
    this.id,
    required this.createdTime,
    required this.customerName,
    required this.itemName,
    required this.itemRate,
    required this.itemQTY,
    required this.totalItem,
    required this.totalQTY,
    required this.totalRate
  });

  Invoice copy({
    int? id,
    DateTime? createdTime,
    String? customerName,
    String? itemName,
    String? itemRate,
    String? itemQTY,
    String? totalItem,
    String? totalQTY,
    String? totalRate,
  }) =>
  Invoice(
        id: id ?? this.id,
  createdTime: createdTime ?? this.createdTime,
  customerName: customerName ?? this.customerName,
  itemName: itemName ?? this.itemName,
  itemRate: itemRate ?? this.itemRate,
  itemQTY: itemQTY ?? this.itemQTY,
  totalItem: totalItem ?? this.totalItem,
  totalQTY: totalQTY ?? this.totalQTY,
  totalRate: totalRate ?? this.totalRate
      );
  static Invoice fromJson(Map<String, Object?> json) => Invoice(
    id: json[InvoiceFields.id] as int?,
  createdTime: DateTime.parse(json[InvoiceFields.time] as String),
  customerName: json[InvoiceFields.customerName] as String,
  itemName: json[InvoiceFields.itemName] as String,
  itemRate: json[InvoiceFields.itemRate] as String,
  itemQTY: json[InvoiceFields.itemQTY] as String,
  totalItem: json[InvoiceFields.totalItem] as String,
  totalQTY: json[InvoiceFields.totalQTY] as String,
  totalRate: json[InvoiceFields.totalRate] as String


  );

  Map<String, Object?> toJson() => {
    InvoiceFields.id: id,
    InvoiceFields.time: createdTime.toIso8601String(),
  InvoiceFields.customerName: customerName,
  InvoiceFields.itemName: itemName,
  InvoiceFields.itemRate: itemRate,
  InvoiceFields.itemQTY: itemQTY,
  InvoiceFields.totalItem: totalItem,
  InvoiceFields.totalQTY: totalQTY,
  InvoiceFields.totalRate: totalRate

  };
}
