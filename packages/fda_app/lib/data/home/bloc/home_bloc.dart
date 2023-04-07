import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fda_app/config/https/http_service.dart';
import 'package:fda_app/data/home/data/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<FetchHome>(_onFetchHome);
  }

  void _onFetchHome(
    FetchHome event,
    emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      final Response response = await HttpService()
          .request(url: "history/user", method: Method.GET, params: {
        'id': event.id,
      });
      final data = response.data["data"] as List;
      List<HistoryObject> result = [];
      data.forEach((element) {
        result.add(HistoryObject.fromJson(element));
      });
      emit(state.copyWith(
          historyList: result,
          numOfAbsent: response.data["numOfAbsent"],
          numOfUnknow: response.data["numOfUnknow"],
          numOfAttendance: response.data["numOfAttendance"],
          status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
