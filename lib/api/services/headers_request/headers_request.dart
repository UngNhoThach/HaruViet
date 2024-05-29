class ApiHeaders {
  final String? authorization;

  ApiHeaders(this.authorization);

  Map<String, String> get appMobileHeaders {
    return {
      "apiconnection": "appmobile",
      "apikey": "9c22991b-e99c-4c4e-9b82-f6b28d4309d5",
      "authorization": "Bearer $authorization",
    };
  }
}
