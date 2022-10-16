import 'package:dio/dio.dart';

class Api {
  late Dio dioClient;

  Api() {
    dioClient = Dio(
      BaseOptions(
        baseUrl: "https://tech-tag.herokuapp.com",
      ),
    );
  }

  Future<dynamic> createUser({
    required String name,
    required String email,
    required String password,
    required String birthDate,
    required String cpf,
    required String phone,
  }) async {
    var response = await dioClient.post(
      "/user",
      data: {
        "name": name,
        "email": email,
        "password": password,
        "cpf": cpf,
        "phone": phone,
        "birthDate": birthDate,
      },
    );

    return response.data;
  }
}
