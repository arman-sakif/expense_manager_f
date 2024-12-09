import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../controller/page_value_controller.dart';
import '../../models/grid_items_model.dart';
import '../../res/app_color.dart';
import '../../routes/routes_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/parent_details_view_model.dart';


class PetGrid extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final List<Pet> pets;
  final String routeName;


  PetGrid({
    required this.itemWidth,
    required this.itemHeight,
    required this.pets,
    required this.routeName,

  });

  @override
  Widget build(BuildContext context) {
    // final parentDetailsViewModel = Provider.of<ParentDetailsViewModel>(context);
    int growthPage = 0;
    PageValueController pageValueController = Get.put(PageValueController());

    return GridView.count(
      crossAxisCount: 2, // Number of columns in the grid
      childAspectRatio: (itemWidth / itemHeight),
      children: List.generate(pets.length, (index) {
        final pet = pets[index];
        return Center(
          child: Card(
            margin: EdgeInsets.all(10),
            color: AppColors.cardBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                // Handle item tap
                pageValueController.growthDetailsPageValue = growthPage;
                pageValueController.childButtonVisible = true;
                print("hello list amete , $index");
                // parentDetailsViewModel.petDetailsApi(context).then((_) {
                Navigator.pushNamed(context, routeName);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)),
                      child: Image.asset(
                        // ImageAssets.dogImage,
                        pet.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              pet.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              pet.gender == 'Male' ? Icons.male : Icons.female,
                              color: AppColors.activeBGColor,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: AutoSizeText(
                            pet.breed,
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            minFontSize: 8,
                            maxFontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: AutoSizeText(
                                'Number of Births: ${pet.number}', // Example usage
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13, // Initial font size
                                ),
                                maxLines: 1,
                                minFontSize: 8,
                                maxFontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 5), // Use SizedBox for spacing
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.activeBGColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AutoSizeText(
                                  pet.status,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, // Font size
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}