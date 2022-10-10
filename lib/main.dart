import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/dissmiss_keyboard.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    var mySystemTheme = const SystemUiOverlayStyle().copyWith(
      systemNavigationBarColor: AppColors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    runApp(const TechTag());
  });
}

class TechTag extends StatelessWidget {
  const TechTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
        title: AppStrings.techTag,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.base,
            selectionColor: AppColors.base,
            selectionHandleColor: AppColors.base,
          ),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
