import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whc_admin/utils/constants.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final bool obscure;
  final IconData icon;
  final bool isNumber;
  final Function(String)? onSubmit;

  const AppTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.readOnly = false,
      this.obscure = false,
      this.icon = Icons.edit,
      this.isNumber = false, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (val){
        onSubmit!(val);
      },
      controller: controller,
      readOnly: readOnly,
      obscureText: obscure,
      inputFormatters: isNumber? [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
      ] : [],
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 16.0,
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: kPrimaryColor)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: kGrey)),
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }
}
