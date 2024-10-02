class ApiHeaders {
  final String? authorization;

  ApiHeaders(this.authorization);

  Map<String, String> get appMobileHeaders {
    return {
      "apiconnection": "appmobile",
      "apikey": "9d003889-89c7-4319-9be0-0796a6c76b00",
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
