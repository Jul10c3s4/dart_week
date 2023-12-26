import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? heigth;
  final double? width;

  const DeliveryButton({super.key, required this.label, required this.onPressed, this.heigth, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: width ?? 16, vertical: heigth ?? 16)
      ),
    );
  }
}
