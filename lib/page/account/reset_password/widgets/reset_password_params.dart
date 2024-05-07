class ResetPasswordParams {
  ResetPasswordParams({
    //  required this.onReload,
    this.phoneNumber,
    required this.timeout,
  });
  // final VoidCallback onReload;
  final String? phoneNumber;
  final int timeout;
}
