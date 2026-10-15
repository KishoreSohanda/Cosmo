import 'package:equatable/equatable.dart';

abstract class ExoplanetEvent extends Equatable {
  const ExoplanetEvent();

  @override
  List<Object?> get props => [];
}

class ExoplanetsRequested extends ExoplanetEvent {
  const ExoplanetsRequested();
}

class MoreExoplanetsRequested extends ExoplanetEvent {
  const MoreExoplanetsRequested();
}
