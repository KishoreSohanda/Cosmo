import 'package:cosmo/features/apod/data/repositories/apod_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cosmo/features/apod/data/models/apod_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApodRepository _repository;

  HomeBloc({required this._repository}) : super(const HomeState()) {
    on<HomeApodRequested>(_onHomeApodRequested);
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
}
