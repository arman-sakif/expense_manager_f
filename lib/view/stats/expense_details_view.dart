import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_details_controller.dart';
import '../../res/app_color.dart';
import '../../res/constant.dart';
import '../../utils/common_header.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/title_box_container.dart';
import '../../utils/utils.dart';

class ParentDetailsPage extends StatefulWidget {
  const ParentDetailsPage({super.key});

  @override
  State<ParentDetailsPage> createState() => _ParentDetailsPageState();
}

class _ParentDetailsPageState extends State<ParentDetailsPage> {
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(title: "Expense Details"),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.005),
                  // Header Row
                  Row(
                    children: [
                      _buildTitleBox("Product Name", 0.2),
                      _buildTitleBox("Expense Amount", 0.3),
                      _buildTitleBox("Expense Date", 0.2),
                    ],
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  // Expense Details Rows
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1, // Assuming only one set of expense details
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              _buildFlexibleBox(
                                  expenseController.product_name.text.isNotEmpty
                                      ? expenseController.product_name.text
                                      : "N/A",
                                  0.2),
                              _buildFlexibleBox(
                                  expenseController.expense_amount.text.isNotEmpty
                                      ? expenseController.expense_amount.text
                                      : "N/A",
                                  0.3),
                              _buildFlexibleBox(
                                  expenseController.expense_date?.isNotEmpty == true
                                      ? expenseController.expense_date.toString()
                                      : "N/A",
                                  0.2),
                            ],
                          ),
                          const Divider(color: AppColors.infoTitleBoxColor),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBox(String title, double flexFactor) {
    return Expanded(
      flex: (flexFactor * 10).toInt(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.grayWhiteColor,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFlexibleBox(String content, double flexFactor) {
    return Expanded(
      flex: (flexFactor * 10).toInt(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
