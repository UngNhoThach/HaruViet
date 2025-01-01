class ApiHeaders {
  final String? authorization;

  ApiHeaders(this.authorization);

  Map<String, String> get appMobileHeaders {
    return {
      "apiconnection": "appmobile",
      "apikey": "03e82b195ca2ec3399eee0532116f999",
      "authorization": "Bearer $authorization",
    };
  }

// giao hang tiet kiem
  Map<String, String> get giaohangtietkiemHeaders {
    return {
      "token": "90be77e166df6F04428AFADaFBE8fA7584b15CB8",
      "Content-Type": "application/json",
    };
  }
}

Map<String, String> appDefaultHeader({
  required String name,
  required String apiKey,
}) {
  return {
    "name": name,
    "apiKey": apiKey,
  };
}
