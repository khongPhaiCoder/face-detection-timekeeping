part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.numOfAbsent = 0,
    this.status = FormzSubmissionStatus.initial,
    this.numOfUnknow = 0,
    this.numOfAttendance = 0,
    this.historyList = const [],
  });
  final FormzSubmissionStatus status;
  final List<HistoryObject> historyList;
  final int numOfAbsent;
  final int numOfUnknow;
  final int numOfAttendance;
  HomeState copyWith({
    int? numOfAbsent,
    int? numOfAttendance,
    FormzSubmissionStatus? status,
    int? numOfUnknow,
    List<HistoryObject>? historyList,
  }) {
    return HomeState(
      numOfAbsent: numOfAbsent ?? this.numOfAbsent,
      numOfAttendance: numOfAttendance ?? this.numOfAttendance,
      status: status ?? this.status,
      historyList: historyList ?? this.historyList,
      numOfUnknow: numOfUnknow ?? this.numOfUnknow,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        numOfAttendance,
        numOfUnknow,
        historyList,
        numOfAbsent,
        status,
      ];
}
