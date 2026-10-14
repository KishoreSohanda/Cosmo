import 'package:cosmo/features/nasa_images/data/models/nasa_image_model.dart';
import 'package:equatable/equatable.dart';

abstract class NasaImagesEvent extends Equatable {
  const NasaImagesEvent();

  @override
  List<Object?> get props => [];
}

class NasaImagesRequested extends NasaImagesEvent {
  const NasaImagesRequested();
}

class NasaImagesNextPageRequested extends NasaImagesEvent {
  const NasaImagesNextPageRequested();
}

class NasaImageDetailsRequested extends NasaImagesEvent {
  final NasaImageModel image;

  const NasaImageDetailsRequested(this.image);

  @override
  List<Object?> get props => [image];
}
