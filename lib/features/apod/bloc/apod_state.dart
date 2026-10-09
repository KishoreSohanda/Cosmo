import 'package:cosmo/features/apod/data/models/apod_model.dart';
import 'package:equatable/equatable.dart';

enum ApodStatus { initial, loading, success, failure }

class ApodState extends Equatable {
  final ApodStatus status;
  final List<ApodModel> apods;
  final String? errorMessage;

  const ApodState({
    this.status = ApodStatus.initial,
    this.apods = const [],
    this.errorMessage,
  });
  ApodState copyWith({
    ApodStatus? status,
    List<ApodModel>? apods,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ApodState(
      status: status ?? this.status,
      apods: apods ?? this.apods,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, apods, errorMessage];
}
