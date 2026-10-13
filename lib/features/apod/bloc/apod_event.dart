import 'package:equatable/equatable.dart';

abstract class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object?> get props => [];
}

class ApodListRequested extends ApodEvent {
  const ApodListRequested();
}

class ApodNextPageRequested extends ApodEvent {
  const ApodNextPageRequested();
}
