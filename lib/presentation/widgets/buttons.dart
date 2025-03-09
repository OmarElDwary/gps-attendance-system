import 'package:flutter/material.dart';

class CheckInOutButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final double borderRadius;

  const CheckInOutButton({
    required this.label,
    required this.color,
    required this.onPressed,
    this.borderRadius = 10.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
