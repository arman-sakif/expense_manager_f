import 'dart:convert';

import 'package:expense_manager/routes/routes_name.dart';
import 'package:expense_manager/view_model/auth_view_model.dart';
import 'package:expense_manager/view_model/child_details_view_model.dart';
import 'package:expense_manager/view_model/child_list_view_model.dart';
import 'package:expense_manager/view_model/parent_list_view_model.dart';
import 'package:expense_manager/view_model/user_view_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller/network_controller.dart';
import 'controller/page_value_controller.dart';
import 'controller/userid_controller.dart';
import 'dependency_injection.dart';
import 'l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import 'view_model/child_growth_view_model.dart';
import 'view_model/companyDetails_view_model.dart';
import 'view_model/member_list_view_model.dart';
import 'view_model/parent_details_view_model.dart';
import 'view_model/parent_view_model.dart';
import 'view_model/profile_view_model.dart';
import 'view_model/view_growth_list_view_model.dart';


// void main() {
//   runApp(const MainPage());
// }

void main() async {
  if(kIsWeb){

  }else{
    WidgetsFlutterBinding.ensureInitialized();
  }

  runApp(
    Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;

        // Set minWidth and maxWidth based on percentages of screenWidth
        final minWidth = screenWidth * 0.2; // 20% of screen width
        final maxWidth = screenWidth * 0.4; // 80% of screen width

        final runnableApp = _buildRunnableApp(
          isWeb: kIsWeb,
          minWidth: minWidth,
          maxWidth: maxWidth,
          app: const MainPage(),
        );

        return runnableApp;
      },
    ),
  );

  DependencyInjection.init();
  Get.put(NetworkController());

  // runApp(AppWrapper(
  //   child: const MainPage(),
  // ));
  // DependencyInjection.init();
  // Get.put(NetworkController()); // Initialize NetworkController
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double minWidth,
  required double maxWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
      ),
      child: SizedBox(
        width: double.infinity,
        child: app,
      ),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    //always portrait mode orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // optional
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ExpenseListViewModel()),
        ChangeNotifierProvider(create: (_) => ChildListViewModel()),
        ChangeNotifierProvider(create: (_) => ParentDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => ChildDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ParentViewModel()),
        ChangeNotifierProvider(create: (_) => MemberListViewModel()),
        ChangeNotifierProvider(create: (_) => CompanyDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => ChildGrowthViewModel()),

      ],
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1200), // Set the minimum width
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          //always light mode
          themeMode: ThemeMode.light,
          initialRoute: RoutesName.splash,
          // initialRoute: RoutesName.menu,
          onGenerateRoute: Routes.generateRoute,

        ),
      ),
    );
  }
}

