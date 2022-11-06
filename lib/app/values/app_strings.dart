class AppStrings {
  //General
  static const techTag = "TechTag";
  //static const baseUrl = "https://tech-tag.herokuapp.com";
  static const baseUrl = "http://localhost:3333";

  //Login
  static const String login = "Fazer Login";
  static const String createAccount = "Criar uma conta";
  static const String labelEmail = "E-mail";
  static const String labelPassword = "Senha";
  static const String forgotPassword = "Esqueci minha senha";
  static const String getIn = "Entrar";

  //Register
  static const String whoAreYou = "01. Quem é você?";
  static const String labelFullName = "Nome Completo";
  static const String labelPhone = "Phone";
  static const String labelBirthDate = "Data Nascimento";
  static const String labelCpf = "CPF";
  static const String next = "Próximo";

  //Cart
  static const String cartTitle = "Carrinho 🧺";

  //Payment Method
  static const String paymentMethodTitle = "Pagamento 💳";

  static const String errorName = 'Digite seu nome completo';
  static const String errorBirthday = 'Data inválida';
  static const String errorUnder18 = 'Menor de 18 anos';
  static const String errorOver118 = 'Mais de 118 anos';
  static const String errorPhone = 'Número de telefone inválido';
  static const String errorEmail = 'Digite um e-mail válido';
  static const String errorPasswordTooShort = 'A senha deve ter pelo menos 6 caracteres';
  static const String errorCpf = 'CPF inválido';
  static const String errorCpfAlreadyUsed = 'CPF já cadastrado. Por favor, ';
  static const String errorPasswordCharacterAllTheSame =
      'A senha deve conter pelo menos dois números diferentes';
  static const String errorPasswordFormat = 'A senha deve conter letras e números';
  static const String errorPasswordFormatNumber = 'A senha deve conter apenas números';
  static const String errorEmptyPassword = 'Digite sua senha';
  static const String errorPasswordMismatch = 'A confirmação da senha é diferente da senha';
  static const String errorCardNumber = 'Número do cartão inválido!';
  static const String errorDate = 'Data inválida!';
  static const String errorCvv = 'Cvv inválido!';

  static const String emailAndPassword = "02. Email e Senha";
  static const String completeRegistration = "Concluir cadastro";

  //Regular expressions
  static const String reEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String rePassword = r'(?:\d.*[a-zA-Z]|[a-zA-Z].*\d)';
  static const String reName = r"[A-Za-zÀ-ÖØ-öø-ÿ0-9']+\s+[A-Za-zÀ-ÖØ-öø-ÿ0-9']+";
  static const String reDate = r'(\d{2})/(\d{2})/(\d{4})';
  static const String reExpirationDate = r'(\d{2})/(\d{2})';
  static const String reCpf = r'^\d{11}$';
  static const String reCnpj = r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$';
  static const String reNotNumber = r'[^\d]';
  static const String reOnlyNumbers = r'\D';
  static const String rePhone = r'^\(\d{2}\)\d{4,5}-\d{4}$';
}
