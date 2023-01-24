import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });
  final String text;
  final Icon icon;
  final Color color;
  final Color textColor;
  final Color borderColor;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: borderColor),
        ),
      ),
      icon: icon,
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
