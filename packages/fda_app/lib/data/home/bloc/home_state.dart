part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.numOfAbsent = 0,
    this.numOfUnknow = 0,
    this.numOfAttendance = 0,
  });
  final int numOfAbsent;
  final int numOfUnknow;
  final int numOfAttendance;
  HomeState copyWith({
    int? numOfAbsent,
    int? numOfAttendance,
    int? numOfUnknow,
  }) {
    return HomeState(
      numOfAbsent: numOfAbsent ?? this.numOfAbsent,
      numOfAttendance: numOfAttendance ?? this.numOfAttendance,
      numOfUnknow: numOfUnknow ?? this.numOfUnknow,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        numOfAttendance,
        numOfUnknow,
        numOfAbsent,
      ];
}
