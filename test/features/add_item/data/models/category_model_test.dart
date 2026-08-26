import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/add_item/data/models/category_model.dart';

void main() {
  group('CategoryModel Tests', () {
    test('should instantiate CategoryModel correctly with given values', () {
      const model = CategoryModel(
        id: 'cat_1',
        title: 'Electronics',
        subtitle: 'Gadgets & Cameras',
        icon: Icons.camera_alt,
        color: Colors.blue,
      );

      expect(model.id, 'cat_1');
      expect(model.title, 'Electronics');
      expect(model.subtitle, 'Gadgets & Cameras');
      expect(model.icon, Icons.camera_alt);
      expect(model.color, Colors.blue);
    });
  });
}
