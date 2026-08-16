


sealed class ResendOtpState {}

final class ResendOTPLoading extends ResendOtpState {}
final class ResendOTPSuccess extends ResendOtpState {}
final class ResendOTPFail extends ResendOtpState {
  final String message;
  ResendOTPFail(this.message);
}
