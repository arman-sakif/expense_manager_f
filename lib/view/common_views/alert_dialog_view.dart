import 'package:flutter/material.dart';

class AlertDialogView extends StatefulWidget {
  const AlertDialogView({super.key});

  @override
  State<AlertDialogView> createState() => _AlertDialogViewState();
}

class _AlertDialogViewState extends State<AlertDialogView> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SelectableContainer(text: 'Option 1'),
                SizedBox(height: 10),
                SelectableContainer(text: 'Option 2'),
                SizedBox(height: 10),
                SelectableContainer(text: 'Option 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class SelectableContainer extends StatelessWidget {
  final String text;
  const SelectableContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle container tap
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
