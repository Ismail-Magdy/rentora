class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final double distance;
  final String imageUrl;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      id: documentId,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'distance': distance,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
