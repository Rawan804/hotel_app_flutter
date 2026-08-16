part of 'login_cubit.dart';
 class LoginState {}
final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
 final User user;

 LoginSuccess(this.user);
}
class LoginFailure extends LoginState {
 final String message;

 LoginFailure(this.message);
}