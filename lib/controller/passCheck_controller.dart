import 'package:flutter/material.dart';
import '../../controller/passCheck_controller.dart';
import '../routes/routes_name.dart';



class PasswordValidator {
  static bool isValidPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    // Add more conditions like checking for special characters, numbers, etc.
    return true;
  }

  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}

class SignInValidator {
  static bool isValidSignIn(String email, String password) {
    // Skip checking procedure for now
    return true; // Default value for now
  }
}





//Verification check


class AuthValidators {
  static void validateInputs(
      BuildContext context,
      String status,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController,
      TextEditingController nameController,
      Function(String?) setSignInError,
      Function(String?) setPasswordError,
      Function(String?) setConfirmPasswordError,
      ) {
    String? signInError;
    String? passwordError;
    String? confirmPasswordError;

    if (status == 'Sign In') {
      // Validate sign-in inputs
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        signInError = 'Please fill in all fields';
      }

      else if (passwordController.text.length< 8){

        signInError ="Password must be at least 8 characters." ;
      }

      else {
        // Check sign-in validity
        bool isValidSignIn = SignInValidator.isValidSignIn(
          emailController.text,
          passwordController.text,
        );

        if (!isValidSignIn) {
          signInError = 'Invalid email or password';
        }
      }

      // Set sign-in error if any
      setSignInError(signInError);

      // Navigate to success page if sign-in is valid
      if (signInError == null) {
        Navigator.popAndPushNamed(
          context,
          // MaterialPageRoute(
          //   builder: (context) => SuccessPage(
          //     email: emailController.text,
          //     password: passwordController.text,
          //     name: '', // Empty name for sign-in
          //   ),
          // ),
          RoutesName.menu
        );
      }
    } else {
      // Validate sign-up inputs
      passwordError = PasswordValidator.isValidPassword(passwordController.text)
          ? null
          : 'Password must be at least 8 characters long';
      confirmPasswordError = PasswordValidator.passwordsMatch(
        passwordController.text,
        confirmPasswordController.text,
      )
          ? null
          : 'Passwords do not match';

      // Set password errors if any
      setPasswordError(passwordError);
      setConfirmPasswordError(confirmPasswordError);

      // Navigate to success page if passwords are valid
      if (passwordError == null && confirmPasswordError == null) {
        Navigator.popAndPushNamed(
            context,
            // MaterialPageRoute(
            //   builder: (context) => SuccessPage(
            //     email: emailController.text,
            //     password: passwordController.text,
            //     name: '', // Empty name for sign-in
            //   ),
            // ),
            RoutesName.menu
        );
      }
    }
  }
}