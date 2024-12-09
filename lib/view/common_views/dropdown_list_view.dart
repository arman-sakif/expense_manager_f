import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/expense_details_controller.dart';
import '../../res/app_color.dart';
import '../../utils/common_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/components/textComponents/rounded_text_input_field.dart';
import '../../utils/utils.dart';

/// This class receives a title and a disease list from the DiseaseTesting class and displays the list of diseases.
/// At the end of the list, you can add a disease by showing a dialog, allowing the user to input a new disease.

class DropdownListView extends StatefulWidget {
  final String title;
  final List<String> items;

  const DropdownListView({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  State<DropdownListView> createState() => _DropdownListViewState();
}

class _DropdownListViewState extends State<DropdownListView> {
  late Future<List<String>> _itemsFuture;
  final ExpenseController parentDetailsController = Get.put(ExpenseController());

  @override
  void initState() {
    super.initState();
    _itemsFuture = Future.value(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          // CommonHeader(title: widget.title),
          CommonHeader(
              title: widget.title,
              onBackPress: () {
                // when back from this page the controller for the selected "Others" disease option to close.
                parentDetailsController.showGeneticDiseaseInput.value = false;
                Navigator.of(context).pop();
              }),
      customDivider(color: AppColors.infoTitleBoxColor,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
              child: FutureBuilder<List<String>>(
                future: _itemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(AppLocalizations.of(context)!.unexpectedError));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(AppLocalizations.of(context)!.noData));
                  } else {
                    final items = snapshot.data!;
                    // Ensure "Others" is only added once
                    // check the controller for the selected "Others" disease option to show.
                    if (!items.contains(AppLocalizations.of(context)!.othersGeneticDisease) && parentDetailsController.showGeneticDiseaseInput.value == true) {
                      items.add(AppLocalizations.of(context)!.othersGeneticDisease);
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (items[index] == AppLocalizations.of(context)!.othersGeneticDisease && parentDetailsController.showGeneticDiseaseInput.value == true) {
                                    // Show popup when "Others" is tapped
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: AppColors.whiteColor,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.othersGeneticDisease,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                customDivider(
                                                  color: AppColors.infoTitleBoxColor,
                                                ),
                                                RoundedTextInputField(
                                                  name: AppLocalizations.of(context)!.enterGeneticDisease,
                                                  characterLimit: 20,
                                                  textEditingController: parentDetailsController.inputGeneticDiseaseController,
                                                ),
                                                SizedBox(height: screenHeight * 0.03),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: List.generate(2, (index) {
                                                    return Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            if (index == 0) {
                                                              // Cancel Button: Close the dialog
                                                              Navigator.of(context).pop(false);
                                                            } else if (index == 1) {
                                                              // Register Button: Save the input and pop both dialog and previous screen
                                                              String inputValue = parentDetailsController.inputGeneticDiseaseController.text;

                                                              // Clear the controller after getting the value
                                                              parentDetailsController.inputGeneticDiseaseController.clear();

                                                              // Close the dialog first
                                                              Navigator.of(context).pop();

                                                              // Close the previous screen and return the input value
                                                              Navigator.of(context).pop({'index': -1, 'value': inputValue});
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: 12, horizontal: 14),
                                                            height: MediaQuery.of(context).size.height * 0.07,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: AppColors.inActiveBoxColor,
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                              color: Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                index == 0 ? AppLocalizations.of(context)!.cancel :
                                                                AppLocalizations.of(context)!.register,
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: AppColors.blackColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                                SizedBox(height: screenHeight * 0.03),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    // Handle the normal list item tap
                                    _onItemTapped(context, index, items[index]);
                                  }
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(items[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 10,
                                thickness: 2,
                                indent: 2,
                                color: AppColors.dividerColor,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index, String item) {
    Navigator.pop(context, {'index': index, 'value': item});
    // Navigator.pop(context, {'index': index, 'value': items[index]});
    print("Tapped on $item");
  }
}
