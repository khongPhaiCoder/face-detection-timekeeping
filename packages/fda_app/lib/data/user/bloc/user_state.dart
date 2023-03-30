part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.user = const User(),
    this.status = FormzSubmissionStatus.initial,
    this.statusLoadingHome = FormzSubmissionStatus.initial,
    this.errorMessage,
  });
  final User user;
  final String? errorMessage;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusLoadingHome;

  UserState copyWith({
    User? user,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusLoadingHome,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      statusLoadingHome: statusLoadingHome ?? this.statusLoadingHome,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, user, statusLoadingHome, errorMessage];
}
