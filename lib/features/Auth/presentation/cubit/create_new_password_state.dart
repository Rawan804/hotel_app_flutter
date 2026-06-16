class PasswordState {
  final String password;
  final String confirmPassword;

  final bool hasUpper;
  final bool hasLower;
  final bool hasNumber;
  final bool hasSpecial;
  final bool hasLength;

  final bool isMatch;

  const PasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.hasUpper = false,
    this.hasLower = false,
    this.hasNumber = false,
    this.hasSpecial = false,
    this.hasLength = false,
    this.isMatch = false,
  });

  bool get isStrong =>
      hasUpper &&
          hasLower &&
          hasNumber &&
          hasSpecial &&
          hasLength;

  double get strength {
    int score = 0;

    if (hasUpper) score++;
    if (hasLower) score++;
    if (hasNumber) score++;
    if (hasSpecial) score++;
    if (hasLength) score++;

    return score / 5;
  }

  PasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? hasUpper,
    bool? hasLower,
    bool? hasNumber,
    bool? hasSpecial,
    bool? hasLength,
    bool? isMatch,
  }) {
    return PasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      hasUpper: hasUpper ?? this.hasUpper,
      hasLower: hasLower ?? this.hasLower,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecial: hasSpecial ?? this.hasSpecial,
      hasLength: hasLength ?? this.hasLength,
      isMatch: isMatch ?? this.isMatch,
    );
  }
}
class NewPasswordLoading extends PasswordState{}
class NewPasswordSuccess extends PasswordState{}
class NewPasswordFail extends PasswordState{
  final String message;
  NewPasswordFail(this.message);
}