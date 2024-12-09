import 'package:flutter/material.dart';
import '../../res/app_color.dart';
import 'custom_floating_sheet.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Container(
        color: Colors.grey[200], // Set the background color here
        child: Stack(
          children: [
            ListView.builder(
              itemCount: 50,
              padding: EdgeInsets.only(bottom: 220.0), // Adjust the bottom padding as needed
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomFloatingActionSheet(
                backgroundColor: AppColors.whiteColor.withOpacity(0.8),
                buttons: [
                  {
                    'Button 1': () async {
                      // Perform any action, like an API call
                      print('Button 1 pressed');
                    }
                  },
                  {
                    'Button 2': () async {
                      // Navigate to Page 2
                      Navigator.pushNamed(context, '/page2');
                    }
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Text('This is Page 1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('This is Page 2'),
      ),
    );
  }
}
