import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/exoplanet_repository.dart';
import 'exoplanet_event.dart';
import 'exoplanet_state.dart';

class ExoplanetBloc extends Bloc<ExoplanetEvent, ExoplanetState> {
  final ExoplanetRepository repository;

  static const int pageSize = 10;

  String? _lastPlanetName;

  ExoplanetBloc({required this.repository}) : super(const ExoplanetState()) {
    on<ExoplanetsRequested>(_onExoplanetsRequested);
    on<MoreExoplanetsRequested>(_onMoreExoplanetsRequested);
  }

  Future<void> _onExoplanetsRequested(
    ExoplanetsRequested event,
    Emitter<ExoplanetState> emit,
  ) async {
    _lastPlanetName = null;

    emit(
      state.copyWith(
        status: ExoplanetStatus.loading,
        exoplanets: [],
        hasMore: true,
        isLoadingMore: false,
        clearError: true,
      ),
    );

    try {
      final exoplanets = await repository.fetchExoplanets(limit: pageSize);

      if (exoplanets.isNotEmpty) {
        _lastPlanetName = exoplanets.last.name;
      }

      emit(
        state.copyWith(
          status: ExoplanetStatus.success,
          exoplanets: exoplanets,
          hasMore: exoplanets.length == pageSize,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ExoplanetStatus.failure,
          errorMessage: 'Unable to load exoplanets. Please try again.',
        ),
      );
    }
  }

  Future<void> _onMoreExoplanetsRequested(
    MoreExoplanetsRequested event,
    Emitter<ExoplanetState> emit,
  ) async {
    if (state.status != ExoplanetStatus.success ||
        state.isLoadingMore ||
        !state.hasMore ||
        _lastPlanetName == null) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final newExoplanets = await repository.fetchExoplanets(
        limit: pageSize,
        afterPlanetName: _lastPlanetName,
      );

      if (newExoplanets.isNotEmpty) {
        _lastPlanetName = newExoplanets.last.name;
      }

      emit(
        state.copyWith(
          exoplanets: [...state.exoplanets, ...newExoplanets],
          isLoadingMore: false,
          hasMore: newExoplanets.length == pageSize,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Unable to load more exoplanets. Please try again.',
        ),
      );
    }
  }
}
