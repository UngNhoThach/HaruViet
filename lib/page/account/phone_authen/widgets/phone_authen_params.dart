class PhoneAuthParams {
  PhoneAuthParams({
    this.firstName,
    this.password,
    this.passwordConfirmation,
    required this.username,
    required this.timeout,
    this.isUpdatePassWord = false,
  });
  final String? firstName;
  final String? password;
  final String? passwordConfirmation;
  final String username;
  final int timeout;
  final bool isUpdatePassWord;
}
