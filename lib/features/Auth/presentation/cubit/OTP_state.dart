 class OtpState {}

class OtpInitial extends OtpState {}

class OtpTimerRunning extends OtpState {
  final int secondsRemaining;

  OtpTimerRunning(this.secondsRemaining);
}

class OtpTimerFinished extends OtpState {}

class OtpLoading extends OtpState {}

class OtpVerified extends OtpState {}

class OtpResent extends OtpState {}

class OtpError extends OtpState {
  final String message;

  OtpError(this.message);
}