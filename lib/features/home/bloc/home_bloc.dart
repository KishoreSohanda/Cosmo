import 'dart:async';

import 'package:cosmo/features/apod/data/models/apod_model.dart';
import 'package:cosmo/features/apod/data/repositories/apod_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApodRepository _repository;
  Timer? _greetingTimer;

  HomeBloc({required this._repository})
    : super(HomeState(greetingPeriod: _currentGreetingPeriod())) {
    on<HomeApodRequested>(_onHomeApodRequested);
    on<HomeGreetingTimeUpdated>(_onGreetingTimeUpdated);

    _greetingTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => add(const HomeGreetingTimeUpdated()),
    );
  }

  static HomeGreetingPeriod _currentGreetingPeriod() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return HomeGreetingPeriod.morning;
    }

    if (hour >= 12 && hour < 17) {
      return HomeGreetingPeriod.afternoon;
    }

    return HomeGreetingPeriod.evening;
  }

  void _onGreetingTimeUpdated(
    HomeGreetingTimeUpdated event,
    Emitter<HomeState> emit,
  ) {
    final period = _currentGreetingPeriod();

    if (period != state.greetingPeriod) {
      emit(state.copyWith(greetingPeriod: period));
    }
  }

  Future<void> _onHomeApodRequested(
    HomeApodRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading, clearFeaturedApod: true));

    try {
      final result = await _repository.fetchApodList(page: 1, limit: 10);

      if (result.apods.isEmpty) {
        emit(state.copyWith(status: HomeStatus.failure));
        return;
      }

      emit(
        state.copyWith(
          status: HomeStatus.success,
          featuredApod: result.apods.first,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _greetingTimer?.cancel();
    return super.close();
  }
}
