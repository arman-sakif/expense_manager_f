import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controller/profile_controller.dart';
import '../../models/user_model.dart';
import '../../res/app_color.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/rounded_text_input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/user_view_model.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileController profileController =
  Get.put(ProfileController());

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  @override
  void initState() {
    super.initState();
    if(profileController.emailController.text.isEmpty ){
      _fetchProfileData();
    }

  }

  _fetchProfileData() {
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileDetailsApi(context).then((_) {
      setState(() {
        profileController.nameController.text =
            profileViewModel.profileDetails?.body.name ?? "";
        profileController.emailController.text =
            profileViewModel.profileDetails?.body.email ?? "0";

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonHeader(title: AppLocalizations.of(context)!.profileSettings),
            SizedBox(
              height: size.height * 0.03,
            ),
            profileCard(context),
          ],
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: size.height * 0.03),
            Text(
              AppLocalizations.of(context)!.userName,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            RoundedTextInputField(
              name: AppLocalizations.of(context)!.nameText,
              textEditingController: profileController.nameController,
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              AppLocalizations.of(context)!.emailAddressText,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            RoundedTextInputField(
              name: AppLocalizations.of(context)!.emailAddressText,
              textEditingController: profileController.emailController,
              isReadOnly: true,
            ),

            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.02),
              child: CustomButton(
                text: AppLocalizations.of(context)!.change,
                onPressed: () async {
                  // UserModel? user = await getUserData();
                  // setState(() {
                  // });
                  // profileViewModel.profileUpdateApi( context);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
