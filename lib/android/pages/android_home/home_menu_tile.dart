import 'package:flutter/material.dart';

class HomeMenuTile extends StatelessWidget {
  const HomeMenuTile(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.15,
        width: double.maxFinite,
        color: Colors.grey.withOpacity(0.3),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Container(
                width: size.width * 0.5,
                padding: const EdgeInsets.all(3),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Icon(Icons.keyboard_arrow_right_outlined)),
          ],
        ),
      ),
    );
  }
}
