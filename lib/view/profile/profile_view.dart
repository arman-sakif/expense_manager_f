import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../controller/profile_controller.dart';
import '../../controller/signin_controller.dart';
import '../../controller/skID_controller.dart';
import '../../res/app_color.dart';
import '../../routes/routes_name.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/buttonComponents/navigation_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/user_view_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
  final SkIdController skIdController = Get.put(SkIdController());
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController =
  Get.put(ProfileController());

  bool role = false;
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _initPackageInfo();
  }

  _fetchProfileData() {
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileDetailsApi(context).then((_) {
      setState(() {
        profileController.nameController.text =
            profileViewModel.profileDetails?.body.name ?? "";
        profileController.emailController.text =
            profileViewModel.profileDetails?.body.email ?? "";

        // print("this is skId ${widget.skIdController.skIdTextController.value}");
      });
    }).catchError((error) {
      print("Error fetching profile details: $error");
      // Handle any errors, you can log out here as well if desired
      // _logoutUser(context);
    });;
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // if (_roleController.text == '1') {
    //   role = true;
    // }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Adjust the font size based on the screen width
    double fontSize;
    if (screenWidth < 360) {
      fontSize = 14; // Small screens
    } else if (screenWidth < 720) {
      fontSize = 17; // Medium screens
    } else {
      fontSize = 20; // Large screens
    }

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Container(
        color: AppColors.screenBGColor,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              spaceHeight(context: context, size: screenHeight * 0.20),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    // height: screenHeight * 0.80,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: AppColors.whiteColor,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: profileController.nameController.text,
                              textColor: AppColors.blackColor,
                              fontSize: 20,
                              isBold: true,
                            ),

                            customDivider(),
                            NavigationBtn(
                              text: AppLocalizations.of(context)!
                                  .profileSettings,
                              routeName: RoutesName.profileEdit,
                              onPressed:
                                    () async {
                                      final result = await Navigator.pushNamed(
                                      context, RoutesName.profileEdit);
                                      if (result == 2) {
                                          setState(() {

                                          });
                                      }
                                  // Navigator.pushNamed(context, RoutesName.profileEdit);
                                },
                            ),

                            // role
                            //     ?

                            customDivider(),
                            NavigationBtn(
                              text: AppLocalizations.of(context)!
                                  .passwordSettings,
                              routeName: RoutesName.profilePassword,
                            ),
                            SizedBox(height: screenHeight * 0.3),

                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: size.height * 0.01),
                              child: CustomButton(
                                text: AppLocalizations.of(context)!.logout,
                                onPressed: () {
                                  _showDialog();
                                },
                                maximumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.1),
                            Center(
                              child: Text('Version: $_version ($_buildNumber)'),
                            ),
                            SizedBox(height: screenHeight * 0.06),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showDialog() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height * 0.3, // Adjust the height here
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.confirmLogout,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {


                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomButton(
                  text: AppLocalizations.of(context)!.logout,
                  onPressed: () {
                    SignInController signInController = Get.put(SignInController());
                    signInController.emailTextController="";
                    signInController.passwordTextController="";
                    final userPreference =
                    Provider.of<UserViewModel>(context,
                        listen: false);
                    userPreference.remove();

                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.sign_in, (route)=> false);
                  },
                  maximumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
