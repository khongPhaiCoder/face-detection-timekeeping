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

class setTimeWhen extends HomeEvent {
  final String text;
  const setTimeWhen(this.text);

  @override
  List<Object?> get props => [text];
}

class ClearTime extends HomeEvent {
  const ClearTime();

  @override
  List<Object?> get props => [];
}