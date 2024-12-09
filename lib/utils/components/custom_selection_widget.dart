import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../res/app_color.dart';
import '../../res/constant.dart';

class SelectionWidgets extends StatefulWidget {
  final List<String> titles;
  final int? selectedIndex; // New parameter to accept the initial selected index
  final Function(int)? onItemSelected;
  final double? horizontalPadding; // Optional parameter

  SelectionWidgets({required this.titles, this.selectedIndex, this.onItemSelected, this.horizontalPadding});

  @override
  _SelectionWidgetsState createState() => _SelectionWidgetsState();
}

class _SelectionWidgetsState extends State<SelectionWidgets> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex; // Initialize the selected index with the value passed from the parent widget
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    double calculatedHorizontalPadding = widget.horizontalPadding ?? (kIsWeb ? (screenWidth > Constant.mobileBreakpoint ? screenWidth * 0.03 : screenWidth * 0.9) : screenWidth * 0.08);

    return Wrap(
      spacing: 8.0, // spacing between buttons
      children: List.generate(widget.titles.length, (index) {
        final bool isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(selectedIndex!);
            }
          },
          child: Container(
            // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: kIsWeb? screenWidth * 0.03 :screenWidth * 0.08),
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: calculatedHorizontalPadding),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // rounded corners
              color: isSelected ? AppColors.selectionButtonColor : AppColors.grayWhiteColor,
              border: Border.all(
                width: 1,
                color: isSelected ? AppColors.activeBGColor : AppColors.inactiveBorderColor,
              ),
            ),
            child: Text(
              widget.titles[index],
              style: TextStyle(
                color: isSelected ? AppColors.activeBGColor : AppColors.inactiveBorderColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
