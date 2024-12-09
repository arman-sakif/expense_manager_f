import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../res/app_color.dart';
import '../../res/image_assets.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  final TextStyle? textStyle;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Create a new list with "Select a variety" as the first item
    List<String> dropdownItems = [AppLocalizations.of(context)!.varietySelection, ...items];

    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownItems.contains(value) ? value : AppLocalizations.of(context)!.varietySelection, // Default to "Select a variety"
      onChanged: onChanged,
      underline: Container(),
      items: dropdownItems.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: textStyle ?? TextStyle(fontSize: 14,), // Use provided textStyle or default
          ),
        );
      }).toList(),
      icon: Image.asset(
        ImageAssets.downArrow,
        width: 16,
        height: 16,
      ),
    );
  }
}
