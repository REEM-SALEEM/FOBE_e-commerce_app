import 'package:flutter/material.dart';

class Textform extends StatelessWidget {
  final String hinttext;
  final Icon formconsl;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const Textform(
      {super.key,
      required this.hinttext,
      required this.formconsl,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: formconsl,
          hintText: hinttext,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
        validator: validator,
      ),
    );
  }
}
