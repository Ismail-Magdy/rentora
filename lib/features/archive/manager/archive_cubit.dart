import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';
import 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  final HomeRepo _homeRepo;

  ArchiveCubit(this._homeRepo) : super(ArchiveInitial());

  Future<void> getMyProducts() async {
    emit(ArchiveLoading());

    final productsResult = await _homeRepo.getProducts(onlyCurrentUser: true);

    productsResult.fold(
      (failure) => emit(ArchiveError(failure.message)),
      (products) => emit(ArchiveLoaded(myProducts: products)),
    );
  }
}
