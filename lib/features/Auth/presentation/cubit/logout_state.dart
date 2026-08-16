

class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutLoading extends LogoutState {}
class LogoutSuccess extends LogoutState {
  final String message;
  LogoutSuccess(this.message);
}
class LogoutFailure extends LogoutState {
  final String message;
  LogoutFailure(this.message);
}