part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

enum HomeGreetingPeriod { morning, afternoon, evening }

final class HomeState extends Equatable {
  final HomeStatus status;
  final ApodModel? featuredApod;
  final HomeGreetingPeriod greetingPeriod;

  const HomeState({
    this.status = HomeStatus.initial,
    this.featuredApod,
    this.greetingPeriod = HomeGreetingPeriod.evening,
  });

  HomeState copyWith({
    HomeStatus? status,
    ApodModel? featuredApod,
    bool clearFeaturedApod = false,
    HomeGreetingPeriod? greetingPeriod,
  }) {
    return HomeState(
      status: status ?? this.status,
      featuredApod: clearFeaturedApod
          ? null
          : featuredApod ?? this.featuredApod,
      greetingPeriod: greetingPeriod ?? this.greetingPeriod,
    );
  }

  @override
  List<Object?> get props => [status, featuredApod, greetingPeriod];
}
