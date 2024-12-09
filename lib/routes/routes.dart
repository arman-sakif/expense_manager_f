import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../view/auth_views/otp_verify_view.dart';
import '../view/auth_views/password_settings_complete_view.dart';
import '../view/auth_views/registration_email_confirm_view.dart';
import '../view/auth_views/reset_password_request_view.dart';
import '../view/auth_views/sign_in_view.dart';
import '../view/auth_views/sign_up_view.dart';

import '../view/home/expense_entry_view.dart';
import '../view/home/expense_details_view.dart';
import '../view/initial_views/confirmation_splash_view.dart';
import '../view/initial_views/onboarding_view.dart';
import '../view/initial_views/splash_view.dart';
import '../view/menu_view.dart';
import '../view/home/expense_list_view.dart';
import '../view/profile/profile_edit_view.dart';
import '../view/profile/profile_password_view.dart';
import '../view/profile/profile_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'routes_name.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){

      case RoutesName.onboarding:
        return CupertinoPageRoute(builder: (_) =>  Onboarding(),);
      case RoutesName.menu:
        return PageTransition(type: PageTransitionType.bottomToTop, child: MenuView());
      case RoutesName.parent_entry:
        return CupertinoPageRoute(builder: (_) => ExpenseEntryPage(),);

      case RoutesName.splash:
        return CupertinoPageRoute(builder: (_) => SplashScreen(),);
      case RoutesName.parent_list:
        return CupertinoPageRoute(builder: (_) => ExpenseListPage(),);

      // case RoutesName.child_entry:
      //   return CupertinoPageRoute(builder: (_) => ChildEntryPage(),);

      case RoutesName.pet_details:
        return CupertinoPageRoute(builder: (_) => ParentDetailsPage(),);


      case RoutesName.profile:
        return CupertinoPageRoute(builder: (_) => ProfilePage(),);
      case RoutesName.profileEdit:
        return CupertinoPageRoute(builder: (_) => ProfileEditPage(),);

      case RoutesName.profilePassword:
        return CupertinoPageRoute(builder: (_) => ProfilePasswordEditPage(),);

      // case RoutesName.childEditToken:
      //   return CupertinoPageRoute(builder: (_) => ChildEditTokenPage(),);
      case RoutesName.sign_in:
        return CupertinoPageRoute(builder: (_) => SignIn(),);
      case RoutesName.sign_up:
        return CupertinoPageRoute(builder: (_) => SignUp(),);

      case RoutesName.password_settings:
        return CupertinoPageRoute(builder: (_) => RequestResetPasswordPage(),);
      case RoutesName.otp_verify:
        return CupertinoPageRoute(builder: (_) => OtpVerifyView(),);




      case RoutesName.confirm_email_View:
        return CupertinoPageRoute(builder: (_) => ConfirmEmailViewPage(),);
      case RoutesName.confirmation_splash_view:
        return CupertinoPageRoute(builder: (_) => ConfirmationSplashScreen(),);
      case RoutesName.password_settings_completeView:
        return CupertinoPageRoute(builder: (_) => PasswordSettingsCompleteView(),);





      // case RoutesName.disease_testing:
      //   return CupertinoPageRoute(builder: (_) => DiseaseTesting(),);
      default:
        return MaterialPageRoute(builder: (BuildContext context) {  // Use 'context' here
          return Scaffold(  // Remove 'const' here
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.closeScreenTryAgainText),
              ),
            ),
          );
        });

    }
  }
}