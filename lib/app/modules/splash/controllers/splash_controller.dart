import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/boxes.dart';

class SplashController extends GetxController {
  Box? generalBox;
  Box<UserModel>? userBox;

  @override
  void onInit() async {
    userBox = await Hive.openBox<UserModel>(Boxes.userBox);
    generalBox = await Hive.openBox(Boxes.generalBox);

    checkUser();

    super.onInit();
  }

  void checkUser() {
    var user = userBox!.get(0);

    if (user != null) {
      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
