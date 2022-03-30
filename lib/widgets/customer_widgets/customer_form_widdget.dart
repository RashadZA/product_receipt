import 'package:flutter/material.dart';
import 'package:product_receipt/helper/custom_theme.dart';

class CustomerFormWidget extends StatelessWidget {
  final String? name;
  final String? number;
  final String? email;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedNumber;
  final ValueChanged<String> onChangedEmail;

  const CustomerFormWidget({
    Key? key,
    this.name = '',
    this.number = '',
    this.email = '',
    required this.onChangedName,
    required this.onChangedNumber,
    required this.onChangedEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildNumber(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
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


  Widget buildNumber() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: number,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Number", "Enter Mobile Number"),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Number cannot be empty' : null,
    onChanged: onChangedNumber,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 1,
    initialValue: email,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Email", "Enter  Email"),
    validator: (title) => title != null && title.isEmpty
        ? 'The Email cannot be empty'
        : null,
    onChanged: onChangedEmail,
  );
}