import 'package:flutter/material.dart';

class Detailscard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  const Detailscard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff6ba3be),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 35,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff2f3ff),
                  ),
                ),
                Text(
                  subtitle,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xfff2f3ff)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
