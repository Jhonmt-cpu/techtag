import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:techtag/app/components/dissmiss_keyboard.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    Directory directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(UserModelAdapter());

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
            selectionColor: AppColors.background,
            selectionHandleColor: AppColors.background,
          ),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
