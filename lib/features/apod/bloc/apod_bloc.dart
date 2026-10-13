import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/apod_repository.dart';
import 'apod_event.dart';
import 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final ApodRepository _repository;

  ApodBloc({required ApodRepository repository})
    : _repository = repository,
      super(const ApodState()) {
    on<ApodListRequested>(_onApodListRequested);
    on<ApodNextPageRequested>(_onApodNextPageRequested);
  }

  Future<void> _onApodListRequested(
    ApodListRequested event,
    Emitter<ApodState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ApodStatus.loading,
        apods: [],
        currentPage: 0,
        isLoadingMore: false,
        hasMore: true,
        clearErrorMessage: true,
      ),
    );

    try {
      final result = await _repository.fetchApodList(page: 1);

      emit(
        state.copyWith(
          status: ApodStatus.success,
          apods: result.apods,
          currentPage: 1,
          hasMore: 1 < result.totalPages,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ApodStatus.failure,
          errorMessage: 'Failed to load astronomy pictures.',
        ),
      );
    }
  }

  Future<void> _onApodNextPageRequested(
    ApodNextPageRequested event,
    Emitter<ApodState> emit,
  ) async {
    if (state.isLoadingMore ||
        !state.hasMore ||
        state.status != ApodStatus.success) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, clearErrorMessage: true));

    final nextPage = state.currentPage + 1;

    try {
      final result = await _repository.fetchApodList(page: nextPage);

      final existingDates = state.apods.map((apod) => apod.date).toSet();
      final uniqueApods = result.apods
          .where((apod) => !existingDates.contains(apod.date))
          .toList();

      emit(
        state.copyWith(
          apods: [...state.apods, ...uniqueApods],
          currentPage: nextPage,
          isLoadingMore: false,
          hasMore: nextPage < result.totalPages,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more astronomy pictures.',
        ),
      );
    }
  }
}
