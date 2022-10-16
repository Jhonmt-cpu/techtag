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
}
