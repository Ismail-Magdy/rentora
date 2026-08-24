import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';

void main() {
  test('toFirestore contains profile fields and timestamp', () {
    final date = DateTime(2026, 1, 1);
    final user = UserModel(
      userId: 'u1',
      name: 'Ali',
      email: 'a@b.com',
      phoneNumber: '010',
      createdAt: date,
      interests: const ['Tech'],
    );
    final data = user.toFirestore();
    expect(data['userId'], 'u1');
    expect(data['interests'], ['Tech']);
    expect((data['createdAt'] as Timestamp).toDate(), date);
  });

  test('equatable users with same values are equal', () {
    final date = DateTime(2026, 1, 1);
    final a = UserModel(
      userId: 'u1',
      name: 'Ali',
      email: 'a@b.com',
      phoneNumber: '010',
      createdAt: date,
    );
    final b = UserModel(
      userId: 'u1',
      name: 'Ali',
      email: 'a@b.com',
      phoneNumber: '010',
      createdAt: date,
    );
    expect(a, b);
  });
}
