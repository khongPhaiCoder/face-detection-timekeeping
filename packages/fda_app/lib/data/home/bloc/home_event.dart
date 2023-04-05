part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchHome extends HomeEvent {
  final String id;
  const FetchHome(this.id);

  @override
  List<Object?> get props => [id];
}
