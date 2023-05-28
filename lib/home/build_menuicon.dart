import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
    required this.aksi,
    required this.title,
    required this.icon,
  });

  final Widget aksi;
  final String title;
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
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 119, 1, 1),
                Color.fromARGB(255, 197, 49, 38)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10)),
        height: 80,
        width: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
