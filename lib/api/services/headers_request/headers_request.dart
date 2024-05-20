// class ApiHeaders {
//   static const Map<String, String> appMobileHeaders = {
//     "apiconnection": "appmobile",
//     "apikey": "9bb24a85-5556-4902-ada3-4c355b70d19d"
//     "authorization" :
//   };
// }

class ApiHeaders {
  final String? authorization;

  ApiHeaders(this.authorization);

  Map<String, String> get appMobileHeaders {
    return {
      "apiconnection": "appmobile",
      "apikey": "9c143e83-8f62-4742-baaf-92fba6ae51c8",
      "authorization": "Bearer $authorization",
    };
  }
}
