
import 'package:flutter/material.dart';


class HeaderButton extends StatelessWidget {
    const HeaderButton({
    required this.icon,
    required this.onTap,
    
  });
  final IconData icon;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE8EBEC),
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF171717),
          size: 22,
        ),
      ),
    );
  }
}