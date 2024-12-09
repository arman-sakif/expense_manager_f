import 'package:flutter/material.dart';

// Define a common data type for items that can be either text or image
class Item {
  final String value;
  final bool isText; // Indicates whether the item is text or an image

  Item.text(this.value) : isText = true;

  Item.image(this.value) : isText = false;
}

class HomeWidgets extends StatefulWidget {
  final String title;
  final List<Item> items;
  final Function(int)?
      onItemSelected; // Callback function to return selected index

  HomeWidgets({required this.title, required this.items, this.onItemSelected});

  @override
  _HomeWidgetsState createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  int? selectedIndex; // Track the index of the selected item

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 5), // Add spacing between title and items
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // Disable scrolling
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return RadioListTile<int>(
                title: item.isText ? Text(item.value) : null,
                value: index,
                groupValue: selectedIndex,
                onChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                  if (widget.onItemSelected != null) {
                    widget.onItemSelected!(value!);
                  }
                },
                secondary: item.isText
                    ? null
                    : Image.asset(
                        item.value,
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
