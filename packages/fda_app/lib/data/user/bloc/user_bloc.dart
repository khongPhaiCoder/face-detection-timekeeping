import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fda_app/data/user/data/user_repository.dart';
import 'package:fda_app/data/user/user.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserLogin>(_onUserLogin);
  }
  UserRepository userRepository = UserRepository();
  @override
  UserState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return UserState(user: User.fromJson(json['user']));
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    // TODO: implement toJson

    return {'user': state.user.toJson()};
  }

  void _onUserLogin(
    UserLogin event,
    emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      User user = await userRepository.login(event.email, event.password);
      prefs.setBool("isLogin", true);
      emit(state.copyWith(user: user, status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), status: FormzSubmissionStatus.failure));
    }
  }
}
