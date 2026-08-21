class SearchFilterModel {
  final String? text;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? location;
  final String? condition;
  final DateTime? startDate;
  final DateTime? endDate;

  const SearchFilterModel({
    this.text,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.location,
    this.condition,
    this.startDate,
    this.endDate,
  });

  SearchFilterModel copyWith({
    String? text,
    String? category,
    double? minPrice,
    double? maxPrice,
    String? location,
    String? condition,
    DateTime? startDate,
    DateTime? endDate,
    bool clearText = false,
    bool clearCategory = false,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
    bool clearLocation = false,
    bool clearCondition = false,
    bool clearStartDate = false,
    bool clearEndDate = false,
  }) {
    return SearchFilterModel(
      text: clearText ? null : text ?? this.text,
      category: clearCategory ? null : category ?? this.category,
      minPrice: clearMinPrice ? null : minPrice ?? this.minPrice,
      maxPrice: clearMaxPrice ? null : maxPrice ?? this.maxPrice,
      location: clearLocation ? null : location ?? this.location,
      condition: clearCondition ? null : condition ?? this.condition,
      startDate: clearStartDate ? null : startDate ?? this.startDate,
      endDate: clearEndDate ? null : endDate ?? this.endDate,
    );
  }

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) {
    return SearchFilterModel(
      text: json['text'] as String?,
      category: json['category'] as String?,
      minPrice: _toDouble(json['minPrice']),
      maxPrice: _toDouble(json['maxPrice']),
      location: json['location'] as String?,
      condition: json['condition'] as String?,
      startDate: _toDateTime(json['startDate']),
      endDate: _toDateTime(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'category': category,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'location': location,
      'condition': condition,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  bool get isEmpty {
    return text == null &&
        category == null &&
        minPrice == null &&
        maxPrice == null &&
        location == null &&
        condition == null &&
        startDate == null &&
        endDate == null;
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(value.toString());
  }
}