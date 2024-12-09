import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/page_value_controller.dart';
import '../../../res/app_color.dart';
import '../../../res/image_assets.dart';
import '../../functions/image_functions.dart';
import '../../utils.dart';
import '../textComponents/custom_contrainer_textview.dart';
import '../textComponents/custom_textview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParentCardWidget extends StatelessWidget {
  final String title;
  final String parentName;
  // final String? managementNumber;
  final String? gender;
  final String parentId;
  final String microchipNumber;
  final String parentType;
  final String parentVariety;
  final String parentWeight;
  final String parentBirthDate;
  final String parentStatus;
  final String parentImagePath;
  final String? parentControlNumber;
  final String parentChildren;


  const ParentCardWidget({Key? key,
    required this.title,
    required this.parentName,
    // this.managementNumber,
    this.gender,
    required this.parentId,
    required this.microchipNumber,
    required this.parentType,
    required this.parentVariety,
    required this.parentWeight,
    required this.parentBirthDate,
    required this.parentStatus,
    required this.parentImagePath,
    this.parentControlNumber,
     required this.parentChildren


  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    PageValueController pageValueController = Get.put(PageValueController());
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    ImageManager imageManager = ImageManager();
    double imageWidth = screenHeight * 0.16;
    double imageHeight = screenHeight * 0.16;

return Container(
  decoration: BoxDecoration(
    color: pageValueController.listCardColor ? AppColors.grayWhiteColor : AppColors.whiteColor,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
              imageManager.loadImage(
                  parentImagePath, imageWidth, imageHeight),
              // Image.network(
              //   parentImagePath,
              //   width: screenHeight * 0.16,
              //   height: screenHeight * 0.16,
              //   fit: BoxFit.cover,
              // ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: AutoSizeText(
                  gender == "1" ? AppLocalizations.of(context)!.male : AppLocalizations.of(context)!.female,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gender == "1" ? AppColors.lightBlueColor : AppColors.femaleColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  minFontSize: 8,
                  maxFontSize: 13,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parentName ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.009),
              Row(
                children: [
                  CustomContainer(text: AppLocalizations.of(context)!.managementNumber,backgroundColor: AppColors.lightGrayColor,),
                  SizedBox(width: kIsWeb? (screenWidth > 400 ? screenWidth * 0.01 : screenWidth * 0.9) : screenWidth * 0.03),
                  AutoSizeText(
                        // managementNumber,
                          parentControlNumber ?? "not found",
                        // AppLocalizations.of(context)!.demo,
                        style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                    maxFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  CustomContainer(text: AppLocalizations.of(context)!.numberBirths,backgroundColor: AppColors.lightGrayColor,),
                  SizedBox(width: kIsWeb? (screenWidth > 400 ? screenWidth * 0.01 : screenWidth * 0.9) : screenWidth * 0.03),
                  AutoSizeText(
                    parentChildren ?? "__",
                    // AppLocalizations.of(context)!.demo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                    maxFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  CustomContainer(text: AppLocalizations.of(context)!.status,backgroundColor: AppColors.lightGrayColor,),
                  SizedBox(width: kIsWeb? (screenWidth > 400 ? screenWidth * 0.01 : screenWidth * 0.9) : screenWidth * 0.03),
                  AutoSizeText(parentStatus == "0" ? AppLocalizations.of(context)!.inactive : AppLocalizations.of(context)!.active,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12, // Font size
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                    maxFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
            pageValueController.growthDetailsPageValue==1?

    Icon(Icons.arrow_forward_ios, color: AppColors.lightGrayColor):Container(),
      ],
    ),
  ),
);

    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height*.4,
    //   // width: 20,
    //   decoration: BoxDecoration(
    //     color: Colors.white.withOpacity(1.0),
    //     borderRadius: const BorderRadius.all(Radius.circular(30)
    //     ),
    //   ),
    //   child: SizedBox(
    //     height: Utils().mediaCalculation(context, 0.76),
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(top: 20, left: 20, right: 20),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               CustomText(
    //                 text: title,
    //                 fontSize: 20.0,
    //                 isBold: true,
    //                 textColor: AppColors.blackColor,
    //               ),
    //               spaceHeight(context: context, size: .5),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       CustomText(
    //                         text: parentName,
    //                         fontSize: 18.0,
    //                         isBold: false,
    //                         textColor: AppColors.blackColor,
    //                       ),
    //                       CustomText(
    //                         text: parentId,
    //                         fontSize: 14.0,
    //                         isBold: false,
    //                         textColor: AppColors.grayColor,
    //                       ),
    //                       CustomText(
    //                         text: microchipNumber,
    //                         fontSize: 14.0,
    //                         isBold: false,
    //                         textColor: AppColors.grayColor,
    //                       ),
    //                       Padding(
    //                         padding: EdgeInsets.only(top: 10, bottom: 10),
    //                         child: Row(
    //                           children: [
    //                             CustomContainer(
    //                               text: AppLocalizations.of(context)!.cat,
    //                             ),
    //                             spaceWidth(context: context, size: 20),
    //                             CustomContainer(
    //                               text: parentVariety,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //
    //                     ],
    //                   ),
    //                   // spaceWidth(context: context, size: 15),
    //                   Spacer(),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width*.35,
    //                     height: MediaQuery.of(context).size.height*.18,
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(10)),
    //                       child: Image.network(
    //                         parentImagePath,
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               CustomText(
    //                 text: AppLocalizations.of(context)!.status,
    //                 fontSize: 18.0,
    //                 isBold: false,
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(top: 10, bottom: 10),
    //                 child: Row(
    //                   children: [
    //                     CustomContainer(
    //                       text: "${parentWeight}g",
    //                     ),
    //                     spaceWidth(context: context, size: 30),
    //                     CustomContainer(
    //                       text: parentBirthDate,
    //                     ),
    //                     spaceWidth(context: context, size: 30),
    //                     CustomContainer(
    //                       text:  parentStatus == "0" ? AppLocalizations.of(context)!.inactive : AppLocalizations.of(context)!.active,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}