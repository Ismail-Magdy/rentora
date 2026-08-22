import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/search/data/repos/search_repo.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;

  SearchCubit(this._searchRepo) : super(const SearchState());

  void updateText(String value) {
    final text = value.trim();

    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          text: text.isEmpty ? null : text,
          clearText: text.isEmpty,
        ),
        clearError: true,
      ),
    );
  }

  void updateCategory(String? category) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          category: category,
          clearCategory: category == null,
        ),
      ),
    );
  }

  void updateMinPrice(double? minPrice) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          minPrice: minPrice,
          clearMinPrice: minPrice == null,
        ),
      ),
    );
  }

  void updateMaxPrice(double? maxPrice) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          maxPrice: maxPrice,
          clearMaxPrice: maxPrice == null,
        ),
      ),
    );
  }

  void updateLocation(String? location) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          location: location,
          clearLocation: location == null,
        ),
      ),
    );
  }

  void updateCondition(String? condition) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          condition: condition,
          clearCondition: condition == null,
        ),
      ),
    );
  }

  Future<void> search() async {
    if (state.filter.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, results: const []));
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, clearError: true));

    final result = await _searchRepo.searchListings(state.filter);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SearchStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (products) {
        if (products.isEmpty) {
          emit(state.copyWith(status: SearchStatus.empty, results: const []));
          return;
        }

        emit(state.copyWith(status: SearchStatus.success, results: products));
      },
    );
  }

  Future<void> applyFilters() {
    return search();
  }

  void clearFilters() {
    emit(const SearchState());
  }
}
