import 'package:cosmo/features/apod/data/models/apod_model.dart';
import 'package:equatable/equatable.dart';

enum ApodStatus { initial, loading, success, failure }

class ApodState extends Equatable {
  final ApodStatus status;
  final List<ApodModel> apods;
  final String? errorMessage;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasMore;

  const ApodState({
    this.status = ApodStatus.initial,
    this.apods = const [],
    this.errorMessage,
    this.currentPage = 0,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  ApodState copyWith({
    ApodStatus? status,
    List<ApodModel>? apods,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return ApodState(
      status: status ?? this.status,
      apods: apods ?? this.apods,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    apods,
    errorMessage,
    currentPage,
    isLoadingMore,
    hasMore,
  ];
}
