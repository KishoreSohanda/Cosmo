import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/apod_repository.dart';
import 'apod_event.dart';
import 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final ApodRepository _repository;

  ApodBloc({required ApodRepository this._repository})
    : super(const ApodState()) {
    on<ApodListRequested>(_onApodListRequested);
  }

  Future<void> _onApodListRequested(
    ApodListRequested event,
    Emitter<ApodState> emit,
  ) async {
    emit(state.copyWith(status: ApodStatus.loading, clearErrorMessage: true));

    try {
      final apods = await _repository.fetchApodList();

      emit(
        state.copyWith(
          status: ApodStatus.success,
          apods: apods,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ApodStatus.failure,
          errorMessage: 'Failed to load astronomy pictures.',
        ),
      );
    }
  }
}
