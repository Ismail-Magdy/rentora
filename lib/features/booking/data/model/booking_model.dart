class BookingModel {
  final String bookingId;
  final String orderCode;
  final String listingId;
  final String renterId;
  final String ownerId;
  final String startDate;
  final String endDate;
  final int totalDays;
  final num dailyPrice;
  final num securityDeposit;
  final num totalAmount;
  final String paymentMethod;
  final String handoverMethod;
  final String status;
  final dynamic createdAt;

  BookingModel({
    required this.bookingId,
    required this.orderCode,
    required this.listingId,
    required this.renterId,
    required this.ownerId,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.totalAmount,
    required this.paymentMethod,
    required this.handoverMethod,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'orderCode': orderCode,
      'listingId': listingId,
      'renterId': renterId,
      'ownerId': ownerId,
      'startDate': startDate,
      'endDate': endDate,
      'totalDays': totalDays,
      'dailyPrice': dailyPrice,
      'securityDeposit': securityDeposit,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'handoverMethod': handoverMethod,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] ?? '',
      orderCode: json['orderCode'] ?? '',
      listingId: json['listingId'] ?? '',
      renterId: json['renterId'] ?? '',
      ownerId: json['ownerId'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      totalDays: json['totalDays'] ?? 0,
      dailyPrice: json['dailyPrice'] ?? 0,
      securityDeposit: json['securityDeposit'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? 'cash',
      handoverMethod: json['handoverMethod'] ?? 'meetup',
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'],
    );
  }
}
