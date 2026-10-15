import 'package:equatable/equatable.dart';

import '../data/models/exoplanet_model.dart';

enum ExoplanetStatus { initial, loading, success, failure }

class ExoplanetState extends Equatable {
  final ExoplanetStatus status;
  final List<ExoplanetModel> exoplanets;
  final String? errorMessage;
  final bool isLoadingMore;
  final bool hasMore;

  const ExoplanetState({
    this.status = ExoplanetStatus.initial,
    this.exoplanets = const [],
    this.errorMessage,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  ExoplanetState copyWith({
    ExoplanetStatus? status,
    List<ExoplanetModel>? exoplanets,
    String? errorMessage,
    bool clearError = false,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return ExoplanetState(
      status: status ?? this.status,
      exoplanets: exoplanets ?? this.exoplanets,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exoplanets,
    errorMessage,
    isLoadingMore,
    hasMore,
  ];
}
