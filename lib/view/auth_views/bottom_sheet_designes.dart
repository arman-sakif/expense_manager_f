import 'package:flutter/material.dart';

import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart'; // Assuming CustomButton is defined here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Sheet Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bottom Sheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BottomSheetCard1(context);
              },
              child: Text('Show Bottom Sheet 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BottomSheetCard2(context);
              },
              child: Text('Show Bottom Sheet 2'),
            ),
          ],
        ),
      ),
    );
  }

  void BottomSheetCard1(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // Set the background color to white
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(screenHeight * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: screenHeight * 0.03), // Adjust the right padding to accommodate the close icon
                      child: Text(
                        "認証コードが届かない場合は",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Image.asset(ImageAssets.crossIcon),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.00),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                child: Image.asset(
                  ImageAssets.verification_cat, // Replace with your image asset
                  height: 100,
                  width: 100,
                ),
              ),
              Text(
                "以下の理由で届いていない可能性があります。",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "・電話番号が正しく入力されていない。\n・迷惑メールに分類されている。\n【アドレス名】からの受信を許可してください。",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomButton(
                text: "再送信",
                backgroundColor: AppColors.activeBGColor,
                onPressed: () {
                  // Add functionality for the button
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void BottomSheetCard2(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // Set the background color to white
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(screenHeight * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: screenHeight * 0.03), // Adjust the right padding to accommodate the close icon
                      child: Text(
                        "確認メールが届かない場合は",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Image.asset(ImageAssets.crossIcon),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.00),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                child: Image.asset(
                  ImageAssets.confirmation_dog, // Replace with your image asset
                  height: 100,
                  width: 100,
                ),
              ),
              Text(
                "以下の理由で届いていない可能性があります。",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "・メールアドレスが正しく入力されていない。\n・迷惑メールに分類されている。\n【アドレス名】からの受信を許可してください。",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomButton(
                text: "再送信",
                backgroundColor: AppColors.activeBGColor,
                onPressed: () {
                  // Add functionality for the button
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
