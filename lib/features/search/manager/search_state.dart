import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/search/data/models/search_filter_model.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  empty,
  error,
  smartSearchLoading,
}

class SearchState {
  final SearchStatus status;
  final SearchFilterModel filter;
  final List<ProductModel> results;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.filter = const SearchFilterModel(),
    this.results = const [],
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    SearchFilterModel? filter,
    List<ProductModel>? results,
    String? errorMessage,

    bool clearError = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      results: results ?? this.results,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
