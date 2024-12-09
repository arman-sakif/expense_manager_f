import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../../controller/profile_controller.dart';
import '../../controller/skID_controller.dart';
import '../../models/user_model.dart';
import '../../res/app_color.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/rounded_text_input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';
import '../../view_model/companyDetails_view_model.dart';
import '../../view_model/user_view_model.dart';

class BusinessEditRequest extends StatefulWidget {
  @override
  State<BusinessEditRequest> createState() => _BusinessEditRequestState();
}

class _BusinessEditRequestState extends State<BusinessEditRequest> {
  final SkIdController skIdController = Get.find();
  Future<UserModel?> getUserData() => UserViewModel().getUser();
  ProfileController profileController = Get.put(ProfileController());

  get fontSize => null;

  @override
  void initState() {
    super.initState();
    // final profileViewModel =
    // Provider.of<ProfileViewModel>(context, listen: false);
    // // print(profileViewModel!.body.name);
    // profileViewModel.profileDetailsApi(context).then((_) {
    //   Utils.showLoading(context);
    //   setState(() {
    //     // _nameController.text = profileViewModel.profileDetails?.body.user_name ?? "";
    //     Utils.cancelLoading(context);
    //   });
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final companyViewModel =
    //   Provider.of<CompanyDetailsViewModel>(context, listen: false);
    //   companyViewModel.companyDetailsApi(context,skIdController.skIdTextController.value).then((_) {
    //     Utils.showLoading(context);
    //     setState(() {
    //
    //       Utils.cancelLoading(context);
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonHeader(title: AppLocalizations.of(context)!.companySetup),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                      text: AppLocalizations.of(context)!.nameText,
                      customStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Spacer(),
                  // SizedBox(
                  //   width: size.width * 0.6,
                  // ),
                  CustomText(
                    // text: AppLocalizations.of(context)!.role,
                    text: profileController.roleController.text,
                    customStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            profileCard(context)
          ],
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _firstNameController = TextEditingController();
    CompanyDetailsViewModel companyViewModel = Provider.of<CompanyDetailsViewModel>(context, listen: false);

    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15,bottom: 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
                  child: Text(AppLocalizations.of(context)!.memberName,
                      style: TextStyle(
                        fontSize: fontSize,
                      )),
                ),

                RoundedTextInputField(
                  name: AppLocalizations.of(context)!.memberName,
                  textEditingController: profileController.companyNameController,
                  // onSubmitted: (value){
                  //   // _nameController.text = value;
                  //   profileController.companyName = value;
                  //   // _nameController.text = value;
                  // },
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
                  child: Text(AppLocalizations.of(context)!.representativeName,
                      style: TextStyle(
                        fontSize: fontSize,
                      )),
                ),
                RoundedTextInputField(
                    name: AppLocalizations.of(context)!.representativeName,
                    textEditingController: profileController.representativeNameController,
                  //   onChanged: (value) {
                  //   _nameController.text = value;
                  //   setState(() {});
                  // },
                  onSubmitted: (value) {
                    // _nameController.text = value;
                    profileController.representativeNameController.text = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(AppLocalizations.of(context)!.zipCode,
                          style: TextStyle(
                            fontSize: fontSize,
                          )),
                      SizedBox(width: 3,),
                      Text(AppLocalizations.of(context)!.required,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: AppColors.requiredColor,
                          )),
                    ],
                  ),
                ),
                RoundedTextInputField(
                  name: AppLocalizations.of(context)!.zipCode,
                  textEditingController: profileController.postCodeController,
                  widthSize: size.width * 0.4,
                  onSubmitted: (value){
                    profileController.postCodeController.text = value;
                  },
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.residence,
                          style: TextStyle(
                            fontSize: fontSize,
                          )),
                      SizedBox(width: 3,),
                      Text(AppLocalizations.of(context)!.required,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: AppColors.requiredColor,
                          )),
                    ],
                  ),
                ),
                RoundedTextInputField(
                    name: AppLocalizations.of(context)!.residence,
                    textEditingController:profileController.locationController,
                  onSubmitted: (value){
                    profileController.locationController.text = value;
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.08),
                  child: CustomButton(
                    text: AppLocalizations.of(context)!.change,
                    onPressed: ()   {
                      // print("submit page");

                      companyViewModel.companyUpdateApi( context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
