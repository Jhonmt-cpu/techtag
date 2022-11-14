import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/data/model/credit_card_model.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/values/app_strings.dart';
import 'package:techtag/app/values/boxes.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Api {
  late Dio dioClient;
  Box<UserModel> userBox = Hive.box<UserModel>(Boxes.userBox);

  static String? accessToken;

  Api() {
    accessToken = userBox.get(0)?.token;

    dioClient = Dio(
      BaseOptions(
        baseUrl: AppStrings.baseUrl,
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

  Future<dynamic> getUser() async {
    var response = await dioClient.get(
      "/account",
    );

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

  Future<Map<String, dynamic>> requestOrder({
    required List<ProductModel> products,
    required CreditCardModel creditCard,
  }) async {
    List<Map<String, dynamic>> orderProducts = products.map((e) => e.toOrderProductMap()).toList();

    var response = await dioClient.post(
      "/purchase",
      data: {
        "products": orderProducts,
        "cardNumber": creditCard.cardNumber,
        "cardName": creditCard.cardHolder,
        "cardExpirationDate": creditCard.expireDate,
        "type": "credit",
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getOrder(String orderId) async {
    var response = await dioClient.get(
      "/order/$orderId",
    );

    return response.data;
  }

  Socket getOrderSocket() {
    return io(
      AppStrings.baseUrl,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
  }
}
