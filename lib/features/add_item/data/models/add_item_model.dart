class AddItemModel {
  String id;
  final String userId;
  final String category;
  final String title;
  final String description;
  final String condition;
  final double dailyPrice;
  final double securityDeposit;
  final String location;
  final List<String> imageUrls;
  final DateTime createdAt;
  bool isAvailable;

  AddItemModel({
    this.id = '',
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.condition,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.location,
    required this.imageUrls,
    required this.createdAt,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'category': category,
    'title': title,
    'description': description,
    'condition': condition,
    'dailyPrice': dailyPrice,
    'securityDeposit': securityDeposit,
    'location': location,
    'imageUrls': imageUrls,
    'createdAt': createdAt.toIso8601String(),
    'isAvailable': isAvailable,
  };

  factory AddItemModel.fromMap(String id, Map<String, dynamic> map) =>
      AddItemModel(
        id: id,
        userId: map['userId'] ?? '',
        category: map['category'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        condition: map['condition'] ?? '',
        dailyPrice: (map['dailyPrice'] ?? 0).toDouble(),
        securityDeposit: (map['securityDeposit'] ?? 0).toDouble(),
        location: map['location'] ?? '',
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
        createdAt: DateTime.parse(
          map['createdAt'] ?? DateTime.now().toIso8601String(),
        ),
        isAvailable: map['isAvailable'] ?? true,
      );
}
