
import 'package:flutter/material.dart';

class ImageActionButton extends StatelessWidget {

  const ImageActionButton({
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  });


  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 20,
            color: isDelete
                ? Colors.red.shade600
                : const Color(0xFF202020),
          ),
        ),
      ),
    );
  }
}
