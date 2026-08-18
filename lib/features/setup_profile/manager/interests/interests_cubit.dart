import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';

part 'interests_state.dart';

class InterestsCubit extends Cubit<InterestsState> {
  final SetupProfileRepo _setupProfileRepo;
  final FirebaseAuth _firebaseAuth;

  InterestsCubit(this._setupProfileRepo, this._firebaseAuth)
    : super(InterestsInitial());

  List<String> selectedInterests = [];

  void toggleInterest(String interestId) {
    if (selectedInterests.contains(interestId)) {
      selectedInterests.remove(interestId);
    } else {
      selectedInterests.add(interestId);
    }
    emit(InterestsUpdated(List.from(selectedInterests)));
  }

  Future<void> saveInterests() async {
    if (selectedInterests.isEmpty) {
      emit(InterestsError('Please select at least one interest.'));
      return;
    }

    emit(InterestsSaving());

    final String userId = _firebaseAuth.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      emit(InterestsError('User authentication error. Please login again'));
      return;
    }

    try {
      final result = await _setupProfileRepo.saveUserInterests(
        userId: userId,
        interests: selectedInterests,
      );

      result.fold(
        (failure) => emit(InterestsError(failure.message)),
        (_) => emit(InterestsSavedSuccess()),
      );
    } catch (e) {
      emit(InterestsError('An unexpected error occurred'));
    }
  }
}
