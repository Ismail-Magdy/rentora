part of 'booking_cubit.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingDatesSelected extends BookingState {
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  BookingDatesSelected({
    required this.startDate,
    required this.endDate,
    required this.totalDays,
  });
}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String orderCode;
  BookingSuccess({required this.orderCode});
}

class BookingError extends BookingState {
  final String message;
  BookingError({required this.message});
}
