import 'package:flutter/material.dart';

class LeaveStatusSquare extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final double opacity;

  const LeaveStatusSquare({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    this.opacity = 0.9, // Default opacity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              color: color, // Use the square's color for the count
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
