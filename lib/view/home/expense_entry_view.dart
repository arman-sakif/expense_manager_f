import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/expense_details_controller.dart';
import '../../models/parent_deatils_model.dart';
import '../../models/pet_characteristics_data.dart';
import '../../models/user_model.dart';
import '../../repository/pet_characteristics_repository.dart';
import '../../res/app_color.dart';
import '../../res/constant.dart';
import '../../res/image_assets.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/functions/parent_draft_reg.dart';
import '../common_views/custom_list_selection_widget.dart';
import '../../utils/components/custom_picker.dart';
import '../../utils/components/custom_selection_widget.dart';
import '../../utils/components/textComponents/custom_text_required.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/rounded_text_input_field.dart';
import '../../utils/components/textComponents/rounded_text_multiline_input_field.dart';
import '../../utils/components/title_box_container.dart';
import '../../utils/components/title_box_required_container.dart';
import '../../utils/custom_image_size.dart';
import '../../utils/functions/image_functions.dart';
import '../../utils/utils.dart';
import '../../view_model/user_view_model.dart';
import '../common_views/dropdown_list_view.dart';

class ExpenseEntryPage extends StatefulWidget {
  final String? selectedDisease;
  final String? selectedResult;

  const ExpenseEntryPage({
    super.key,
    this.selectedDisease,
    this.selectedResult,
  });

  @override
  State<ExpenseEntryPage> createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState extends State<ExpenseEntryPage> {
  // Controllers
  final PageValueController pageValueController = Get.put(PageValueController());
  final ExpenseController expenseController = Get.put(ExpenseController());
  ImageManager imageManager = ImageManager();

  // UI State Variables
  late bool visibleValue;
  bool isInkWellVisible = false;

  // Data Variables
  String expenseAmount = "";
  String productName = "";
  String timeOfUse = DateTime.now().toIso8601String(); // Default to current time

// List of possible expenses
  List<String> expenses = [
    "Groceries",
    "Entertainment",
    "Bills",
    "Transportation",
    "Dining out",
    "Health & Fitness",
    "Rent",
    "Utilities",
    "Shopping",
    "Travel",
    "Subscriptions",
    "Mobile phone",
    "Internet",
    "Gas/Fuel",
    "Insurance",
    "Healthcare",
    "Electricity",
    "Water",
    "Childcare",
    "Personal care",
    "Coffee",
    "Online purchases",
    "Pet care",
    "Books & Learning",
    "Gifts & Donations",
    "Car maintenance",
    "Cleaning supplies",
    "Parking fees",
    "Public transport",
    "Bank fees",
    "Debt repayments",
  ];

  String? selectedExpense;

  @override
  void initState() {
    super.initState();
    initializeState();
    addListeners();
  }

  void initializeState() {}

  void addListeners() {}

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2150),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blackColor,
              onPrimary: AppColors.whiteColor,
              onSurface: AppColors.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                iconColor: AppColors.blackColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  @override
  void dispose() {
    // Save the state before disposing of the page
    expenseController.saveParentEntryState();
    super.dispose();
  }

  void clearState() {
    expenseAmount = "";
    productName = "";
    timeOfUse = DateTime.now().toIso8601String();
  }

  Future<void> submitData() async {
    // Replace this with the API call to send the data
    final data = {
      "expense_amount": expenseAmount,
      "product_name": productName,
      "time_of_use": timeOfUse,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', true);
    parentEntry(context);

    // Make the API call with the data
    // Example: await apiService.addExpenseData(data);
    print('Data submitted: $data');
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Column(
        children: [
          CommonHeader(
              title: "Add Data",
              onBackPress: () {
                Navigator.of(context).pop();
              }),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.03,
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleBoxRequiredContainer(
                            containerName: "Expense Category",
                            backgroundColor: Colors.transparent),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grayColor), // Border color
                            borderRadius: BorderRadius.circular(5), // Rounded corners
                          ),
                          child: DropdownButton<String>(
                            hint: Text("Select an expense type"), // Hint text when no value is selected
                            value: selectedExpense, // The selected value
                            isExpanded: true, // Make the dropdown expand to fit the container width
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedExpense = newValue;
                                // Store the selected value in the controller
                                expenseController.product_name.text = newValue ?? '';
                              });
                            },
                            items: expenses.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value), // Display the item
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        customDivider(),
                        SizedBox(height: screenHeight * 0.02),

                        CustomPicker(
                          title: AppLocalizations.of(context)!.birthDate,
                          dateTypeText: "Date",
                          additionalText:
                          expenseController.expense_date?.isNotEmpty == true
                              ? DateFormat('dd-MM-yyyy').format(DateTime.parse(expenseController.expense_date!))
                              : "Select Date",
                          selectDateFunction: () async {
                            final DateTime? picked = await _selectDate(context);
                            if (picked != null) {
                              setState(() {
                                timeOfUse = "${picked.toLocal()}".split(' ')[0];
                                expenseController.expense_date = timeOfUse; // Save to controller
                              });
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        customDivider(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.02,
                              bottom: screenHeight * 0.02),
                          child: Row(
                            children: [
                              TitleBoxRequiredContainer(
                                  containerName: "Amount",
                                  widthSize: kIsWeb?screenWidth * 0.08:screenWidth * 0.3,

                                  backgroundColor: Colors.transparent),
                              Spacer(),
                              Container(
                                width: kIsWeb?screenWidth * 0.04:screenWidth * 0.4,
                                child: RoundedTextInputField(
                                  name: "00",
                                  textEditingController: expenseController.expense_amount,
                                  characterLimit: 6,
                                  type: TextInputType.numberWithOptions(signed: true, decimal: true),
                                  onChanged: (value) {
                                    setState(() {
                                      expenseAmount = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              CustomText(text: "\$"),
                            ],
                          ),
                        ),

                        customDivider(),
                        SizedBox(height: screenHeight * 0.02),

                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.04,
                          ),
                          child: CustomText(
                              text: AppLocalizations.of(context)!.freeEntry,
                              fontSize: 14),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              left: screenWidth * 0.04,
                              right: screenWidth * 0.04),
                          child: RoundedTextMultilineInputField(
                              name: AppLocalizations.of(context)!.myPet,
                              textEditingController: expenseController.aboutPetController,

                              ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            text: AppLocalizations.of(context)!.confirm,
                            backgroundColor: AppColors.activeBGColor,
                            onPressed: submitData, // Submitting data
                            maximumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}