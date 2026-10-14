part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  final HomeStatus status;
  final ApodModel? featuredApod;

  const HomeState({this.status = HomeStatus.initial, this.featuredApod});

  HomeState copyWith({
    HomeStatus? status,
    ApodModel? featuredApod,
    bool clearFeaturedApod = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      featuredApod: clearFeaturedApod
          ? null
          : featuredApod ?? this.featuredApod,
    );
  }

  @override
  List<Object?> get props => [status, featuredApod];
}
