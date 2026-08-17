
import 'package:flutter/material.dart';

class SmallImageAction extends StatelessWidget {
   const SmallImageAction({
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 17,
          color: isDelete
              ? Colors.red
              : const Color(0xFF202020),
        ),
      ),
    );
  }
}
