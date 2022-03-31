import 'package:flutter/material.dart';
import 'package:product_receipt/helper/custom_theme.dart';

class ItemFormWidget extends StatelessWidget {
  final String? name;
  final String? code;
  final String? rate;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedCode;
  final ValueChanged<String> onChangedRate;

  const ItemFormWidget({
    Key? key,
    this.name = '',
    this.code = '',
    this.rate = '',
    required this.onChangedName,
    required this.onChangedCode,
    required this.onChangedRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(height: 8),
          buildCOde(),
          const SizedBox(height: 8),
          buildRate(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildName() => TextFormField(
    maxLines: 1,
    initialValue: name,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Name", "Enter Name"),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Name cannot be empty' : null,
    onChanged: onChangedName,
  );


  Widget buildCOde() => TextFormField(
    maxLines: 1,
    initialValue: code,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Code", "Enter Product Code"),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Code cannot be empty' : null,
    onChanged: onChangedCode,
  );

  Widget buildRate() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: rate,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Rate", "Enter  Rate"),
    validator: (title) => title != null && title.isEmpty
        ? 'The Rate cannot be empty'
        : null,
    onChanged: onChangedRate,
  );
}