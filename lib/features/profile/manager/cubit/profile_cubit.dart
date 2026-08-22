import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';
import 'package:rentora/features/profile/data/repo/profile_repo.dart';
import 'package:rentora/features/profile/manager/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;

  UserModel? currentUser;

  ProfileCubit(this._repo) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      currentUser = await _repo.getProfile();
      emit(ProfileLoaded(currentUser!));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } catch (_) {
      emit(ProfileError('Failed to load profile'));
    }
  }

  Future<void> saveProfile({
    required String name,
    required String phoneNumber,
    required String bio,
    File? avatarFile,
  }) async {
    emit(ProfileUpdating());
    try {
      String? avatarUrl;
      if (avatarFile != null) {
        avatarUrl = await _repo.uploadAvatar(avatarFile);
      }

      currentUser = await _repo.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        bio: bio,
        avatarUrl: avatarUrl,
      );
      emit(ProfileUpdated(currentUser!));
    } on ServerException catch (e) {
      emit(ProfileUpdateError(e.message));
    } catch (_) {
      emit(ProfileUpdateError('Failed to update profile'));
    }
  }
}
