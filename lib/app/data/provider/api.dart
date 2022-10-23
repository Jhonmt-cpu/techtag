import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/values/boxes.dart';

class Api {
  late Dio dioClient;
  Box<UserModel> userBox = Hive.box<UserModel>(Boxes.userBox);

  static String? accessToken;

  Api() {
    accessToken = userBox.get(0)?.token;

    dioClient = Dio(
      BaseOptions(
        baseUrl: "https://tech-tag.herokuapp.com",
      ),
    );

    dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          return handler.next(options);
        },
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

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    var response = await dioClient.post(
      "/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    accessToken = response.data['token'];

    return response.data;
  }

  Future<List<dynamic>> getCategories() async {
    var response = await dioClient.get(
      "/categories",
    );

    return response.data;
  }

  Future<List<dynamic>> getProducts() async {
    var response = await dioClient.get(
      "/product",
    );

    return response.data;
  }
}
