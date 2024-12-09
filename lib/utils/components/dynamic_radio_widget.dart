import 'package:flutter/material.dart';

import '../../models/radio_items_model.dart';
import 'buttonComponents/custom_radio_button.dart';

class DynamicRadioWidget extends StatelessWidget {
  final List<RadioItem> items;
  final int selectedValue;
  final bool horizontal;
  final ValueChanged<int?> onChanged;

  DynamicRadioWidget({
    required this.items,
    required this.horizontal,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.height * 0.03,
        right: MediaQuery.of(context).size.height * 0.03,
      ),
      child: horizontal ? Row(
        children: items
            .map(
              (item) => CustomRadioTile(
            title: item.value, isText : item.isText,
            value: items.indexOf(item),
            groupValue: selectedValue,
            onChanged: onChanged,
          ),
        )
            .toList(),
      ) : Column(
        children: items
            .map(
              (item) => CustomRadioTile(
            title: item.value, isText : item.isText,
            value: items.indexOf(item),
            groupValue: selectedValue,
            onChanged: onChanged,
          ),
        )
            .toList(),
      ),
    );
  }
}