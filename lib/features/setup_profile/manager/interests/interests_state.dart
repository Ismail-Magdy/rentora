part of 'interests_cubit.dart';

@immutable
abstract class InterestsState {}

class InterestsInitial extends InterestsState {}

class InterestsUpdated extends InterestsState {
  final List<String> selectedInterests;
  InterestsUpdated(this.selectedInterests);
}

class InterestsSaving extends InterestsState {}

class InterestsSavedSuccess extends InterestsState {}

class InterestsError extends InterestsState {
  final String error;
  InterestsError(this.error);
}
