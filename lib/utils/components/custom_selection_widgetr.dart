import 'package:flutter/material.dart';

import '../../res/app_color.dart';

class SelectionWidgets extends StatefulWidget {
  final List<String> titles;
  final Function(int)? onItemSelected;

  SelectionWidgets({required this.titles, this.onItemSelected});

  @override
  _SelectionWidgetsState createState() => _SelectionWidgetsState();
}

class _SelectionWidgetsState extends State<SelectionWidgets> {
  int? selectedIndex; // Track the index of the selected item

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Define the padding values based on screen width
    final double horizontalPadding = screenSize.width * 0.080; // 10% of screen width
    final double verticalPadding = 4.0;
    return Wrap(
      spacing: 8.0, // spacing between buttons
      children: List.generate(widget.titles.length, (index) {
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
            padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
            decoration: selectedIndex == index ?BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // rounded corners
              color: AppColors.activeBGColor,
            ):
            BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: AppColors.activeBGColor
              ),// rounded corners
              color: AppColors.whiteColor,
            ),
            child: Text(
              widget.titles[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}

