import 'package:expense_manager/view/stats/stats_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controller/page_value_controller.dart';
import '../res/app_color.dart';
import '../res/constant.dart';
import '../res/image_assets.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';
import 'home/expense_list_view.dart';
import 'profile/profile_view.dart';

class MenuView extends StatefulWidget {
  MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  PageValueController pageValueController = Get.put(PageValueController());
  // late int _selectedIndex = pageValueController.selectedIndex;
  int addParentPhotoPage = Constant.parentAddPhotoValue;
  int addChildPhotoPage = Constant.childAddPhotoValue;
  // PageController _pageController = PageController(initialPage: pageValueController.selectedIndex);
  late final PageController _pageController = PageController(
      initialPage: pageValueController.selectedIndex
  );

  final List<Widget> _pages = [
    ExpenseListPage(),
    StatsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
      setState(() {
        pageValueController.selectedIndex = index ;
        _pageController.jumpToPage(pageValueController.selectedIndex);
      });
    // }
  }

  void _showDialog() {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // bool isParentListPage = _selectedIndex == 0;
        // int initialIndex = isParentListPage ? 0 : 1;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height * 0.3, // Adjust the height here
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.biometricRegistration,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                customDivider(color: AppColors.infoTitleBoxColor,),

                SizedBox(height: screenHeight * 0.03),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Prevents swipe navigation
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            pageValueController.selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.gray2Color,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(ImageAssets.homeIcon),
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(ImageAssets.viewIcon),
            ),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage(ImageAssets.profileIcon),
            ),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
        currentIndex:  pageValueController.selectedIndex ,
        // currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.activeBGColor,
        // showSelectedLabels: true,
        // showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}