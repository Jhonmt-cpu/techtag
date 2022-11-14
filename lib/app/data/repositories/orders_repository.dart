import 'package:socket_io_client/socket_io_client.dart';
import 'package:techtag/app/components/order_model.dart';
import 'package:techtag/app/data/model/credit_card_model.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/data/provider/api.dart';

class OrdersRepository {
  final api = Api();

  static final OrdersRepository _ordersRepository = OrdersRepository._internal();
  OrdersRepository._internal();

  factory OrdersRepository() {
    return _ordersRepository;
  }

  Future<String> requestOrder({
    required List<ProductModel> products,
    required CreditCardModel creditCard,
  }) async {
    var response = await api.requestOrder(
      products: products,
      creditCard: creditCard,
    );

    return response['id'];
  }

  Future<OrderModel> getOrder(String orderId) async {
    var response = await api.getOrder(orderId);

    var order = OrderModel.fromMap(response);

    return order;
  }

  Socket getOrderStream() {
    var socket = api.getOrderSocket();

    return socket;
  }
}
