import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import '../../res/constant.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpController = Get.put(SignUpController());
  final pageValueController = Get.put(PageValueController());
  bool isClicked = false;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    if (pageValueController.registrationPageValue == 1) {
      final profileController = Get.put(ProfileController());
      signUpController.companyNameController =
          profileController.companyNameController;
      signUpController.companyIdController =
          profileController.companyIdController;
      signUpController.parkNameTextController =
          profileController.parkNameController;
    } else {
      signUpController.clearTextFields();
    }
  }

  void _toggleAgreement() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  void _submitForm(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final requiredFields = {
      "Email": signUpController.emailTextController,
      "Password": signUpController.passwordTextController,
      "Name": signUpController.firstNameTextController.isEmpty ||
          signUpController.lastNameTextController.isEmpty
          ? ""
          : "${signUpController.firstNameTextController} ${signUpController.lastNameTextController}",
    };

    for (var field in requiredFields.entries) {
      if (field.value.isEmpty) {
        Utils.flushBarErrorMessage(
            '${field.key} is required.', Icons.error, Colors.red, context);
        return;
      }
    }

    if (!EmailValidator.validate(signUpController.emailTextController)) {
      Utils.flushBarErrorMessage(
          'Please enter a valid email address.',
          Icons.error,
          Colors.red,
          context);
      return;
    }

    if (isClicked) {


      // if (pageValueController.registrationPageValue == 0) {
        authViewModel.signupApi( context);
      // } else {
      //   // authViewModel.invitationApi(context);
      // }
    } else {
      Utils.flushBarErrorMessage(
          'You must agree to the terms and conditions.',
          Icons.error,
          Colors.red,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Column(
        children: [
          CommonHeader(
            title: pageValueController.registrationPageValue == 0
                ? "Member Registration"
                : "Member Invitation",
            hideBackButton: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Email Address",
                      textColor: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    RoundInputField(
                      name: "Email Address",
                      onChanged: (value) =>
                      signUpController.emailTextController = value,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomText(
                      text: "Password",
                      textColor: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    RoundInputField(
                      name: "Password",
                      onChanged: (value) =>
                      signUpController.passwordTextController = value,
                      // textEditingController: signUpController.passwordTextController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomText(
                      text: "Gender",
                      textColor: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grayColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        value: selectedGender,
                        hint: Text("Select Gender"),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                            signUpController.genderController.text = value ?? '';
                          });
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: "male",
                            child: Text("Male"),
                          ),
                          DropdownMenuItem<String>(
                            value: "female",
                            child: Text("Female"),
                          ),
                          DropdownMenuItem<String>(
                            value: "other",
                            child: Text("Other"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomText(
                      text: "Name",
                      textColor: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: RoundInputField(
                            name: "First Name",
                            onChanged: (value) =>
                            signUpController.firstNameTextController = value,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: RoundInputField(
                            name: "Last Name",
                            onChanged: (value) =>
                            signUpController.lastNameTextController = value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: _toggleAgreement,
                      child: Row(
                        children: [
                          Icon(
                            isClicked ? Icons.check_box : Icons.check_box_outline_blank,
                            color: AppColors.activeBGColor,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text("I agree to the terms and conditions."),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomButton(
                      backgroundColor: isClicked
                          ? AppColors.activeBGColor
                          : AppColors.grayColor,
                      text: "Register",
                      onPressed: () => _submitForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
