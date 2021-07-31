part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadedSuccess extends UserState {
  final User user;

  UserLoadedSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserActionFailed extends UserState {
  final String message;

  UserActionFailed(this.message);

  @override
  List<Object> get props => [message];
}

class UserActionSuccess extends UserState {
  final String message;

  UserActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}
