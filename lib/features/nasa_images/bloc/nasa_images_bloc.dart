import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/nasa_images_repository.dart';
import 'nasa_images_event.dart';
import 'nasa_images_state.dart';

class NasaImagesBloc extends Bloc<NasaImagesEvent, NasaImagesState> {
  final NasaImagesRepository _repository;

  NasaImagesBloc({required this._repository}) : super(const NasaImagesState()) {
    on<NasaImagesRequested>(_onImagesRequested);
    on<NasaImagesNextPageRequested>(_onNextPageRequested);
  }

  Future<void> _onImagesRequested(
    NasaImagesRequested event,
    Emitter<NasaImagesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: NasaImagesStatus.loading,
        images: [],
        currentPage: 0,
        isLoadingMore: false,
        hasMore: true,
        clearErrorMessage: true,
      ),
    );

    try {
      final result = await _repository.fetchImages(page: 1);

      emit(
        state.copyWith(
          status: NasaImagesStatus.success,
          images: result.images,
          currentPage: 1,
          hasMore: result.images.length < result.totalHits,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NasaImagesStatus.failure,
          errorMessage: 'Failed to load NASA images.',
        ),
      );
    }
  }

  Future<void> _onNextPageRequested(
    NasaImagesNextPageRequested event,
    Emitter<NasaImagesState> emit,
  ) async {
    if (state.isLoadingMore ||
        !state.hasMore ||
        state.status != NasaImagesStatus.success) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, clearErrorMessage: true));

    final nextPage = state.currentPage + 1;

    try {
      final result = await _repository.fetchImages(page: nextPage);

      final existingIds = state.images.map((image) => image.nasaId).toSet();
      final newImages = result.images
          .where((image) => !existingIds.contains(image.nasaId))
          .toList();

      emit(
        state.copyWith(
          images: [...state.images, ...newImages],
          currentPage: nextPage,
          isLoadingMore: false,
          hasMore: nextPage * 20 < result.totalHits,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: 'Failed to load more NASA images.',
        ),
      );
    }
  }
}
