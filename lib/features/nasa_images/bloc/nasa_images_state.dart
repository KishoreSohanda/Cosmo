import 'package:cosmo/features/nasa_images/data/models/nasa_image_model.dart';
import 'package:equatable/equatable.dart';

enum NasaImagesStatus { initial, loading, success, failure }

enum NasaImageDetailsStatus { initial, loading, success, failure }

class NasaImagesState extends Equatable {
  final NasaImagesStatus status;
  final List<NasaImageModel> images;
  final String? errorMessage;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasMore;
  final NasaImageDetailsStatus detailsStatus;
  final NasaImageModel? selectedImage;
  final String? detailsErrorMessage;

  const NasaImagesState({
    this.status = NasaImagesStatus.initial,
    this.images = const [],
    this.errorMessage,
    this.currentPage = 0,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.detailsStatus = NasaImageDetailsStatus.initial,
    this.selectedImage,
    this.detailsErrorMessage,
  });

  NasaImagesState copyWith({
    NasaImagesStatus? status,
    List<NasaImageModel>? images,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasMore,
    NasaImageDetailsStatus? detailsStatus,
    NasaImageModel? selectedImage,
    String? detailsErrorMessage,
    bool clearDetailsErrorMessage = false,
  }) {
    return NasaImagesState(
      status: status ?? this.status,
      images: images ?? this.images,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      selectedImage: selectedImage ?? this.selectedImage,
      detailsErrorMessage: clearDetailsErrorMessage
          ? null
          : detailsErrorMessage ?? this.detailsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    images,
    errorMessage,
    currentPage,
    isLoadingMore,
    hasMore,
    detailsStatus,
    selectedImage,
    detailsErrorMessage,
  ];
}
