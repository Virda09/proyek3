import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
    required this.aksi,
    required this.title,
    required this.icon,
    required this.role,
  });

  final Widget aksi;
  final String title, role;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => aksi,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: role == "warga"
                ? BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    color: secondaryColor,
                  ),
            height: 70,
            width: role == "warga" ? 100 : 70,
            child: Center(
              child: Icon(
                icon,
                color: primaryColor,
                size: 40,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
