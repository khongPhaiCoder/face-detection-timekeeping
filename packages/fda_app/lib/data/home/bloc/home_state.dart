part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.numOfAbsent = 0,
    this.status = FormzSubmissionStatus.initial,
    this.statusLoad = FormzSubmissionStatus.initial,
    this.numOfUnknow = 0,
    this.numOfAttendance = 0,
    this.totalSalary = '0',
    this.month,
    this.year,
    this.textWhen,
    this.historyList = const [],
  });
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusLoad;
  final List<HistoryObject> historyList;
  final int numOfAbsent;
  final int numOfUnknow;
  final String totalSalary;
  final String? month;
  final String? year;
  final String? textWhen;
  final int numOfAttendance;
  HomeState copyWith({
    int? numOfAbsent,
    int? numOfAttendance,
    String? totalSalary,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusLoad,
    int? numOfUnknow,
    List<HistoryObject>? historyList,
    String? month,
    String? year,
    String? textWhen,
  }) {
    return HomeState(
      numOfAbsent: numOfAbsent ?? this.numOfAbsent,
      totalSalary: totalSalary ?? this.totalSalary,
      statusLoad: statusLoad ?? this.statusLoad,
      month: month ?? this.month,
      year: year ?? this.year,
      textWhen: textWhen ?? this.textWhen,
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
        month,
        year,
        textWhen,
        statusLoad,
        historyList,
        totalSalary,
        numOfAbsent,
        status,
      ];
}
