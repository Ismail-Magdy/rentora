
import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String id;
  final String subtitle;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.id,
  });
}