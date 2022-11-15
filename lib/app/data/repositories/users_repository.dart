import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/data/provider/api.dart';

class UsersRepository {
  final api = Api();

  static final UsersRepository _usersRepository = UsersRepository._internal();
  UsersRepository._internal();

  factory UsersRepository() {
    return _usersRepository;
  }

  Future<dynamic> createUser({
    required String name,
    required String email,
    required String password,
    required String birthDate,
    required String cpf,
    required String phone,
  }) async {
    var response = await api.createUser(
      name: name,
      email: email,
      password: password,
      birthDate: birthDate,
      cpf: cpf,
      phone: phone,
    );

    return response;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var response = await api.login(
      email: email,
      password: password,
    );

    var userModel = UserModel.fromMap(response);

    return userModel;
  }

  Future<void> forgot({
    required String email,
  }) async {
    var response = await api.forgot(
      email: email
    );
    return response;
  }
}
