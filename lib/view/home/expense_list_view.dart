import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../controller/expense_details_controller.dart';
import '../../controller/network_controller.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/parent_controller.dart';
import '../../controller/userid_controller.dart';
import '../../data/response/status.dart';
import '../../models/pet_characteristics_data.dart';
import '../../repository/pet_characteristics_repository.dart';
import '../../res/app_color.dart';
import '../../res/constant.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart';
import '../../utils/components/custom_dropdown.dart';
import '../../utils/components/textComponents/custom_contrainer_textview.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../utils/custom_font_size.dart';
import '../../utils/custom_image_size.dart';
import '../../utils/functions/image_functions.dart';
import '../../utils/utils.dart';
import '../../view_model/parent_list_view_model.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage>
    with WidgetsBindingObserver {
  @override
  String? _deviceToken;

  String selectedVariety = '';
  String additionUrl = "";
  List<String> params = [];
  int? selectedTypeValue = 0;
  int? selectedGenderValue = 0;
  int? selectedStatusValue = 0;

  int? selectedTempTypeValue = 0;
  int? selectedTempGenderValue = 0;
  int? selectedTempStatusValue = 0;

  int addPhotoPage = Constant.parentAddPhotoValue;
  PageValueController pageValueController = Get.put(PageValueController());
  UserIdController userIdController = Get.put(UserIdController());
  final ExpenseController expenseController = Get.put(ExpenseController());

  ImageManager imageManager = ImageManager();

  ExpenseListViewModel parentListViewModel = ExpenseListViewModel();
  ParentController addPhotoController = Get.put(ParentController());
  final ScrollController _scrollController = ScrollController();
  void _onScroll() {
    if(kDebugMode){
      // print("Using Scroll");
      // print(pageValueController.displayItems);
    }


    int totalItem = Provider.of<ExpenseListViewModel>(context, listen: false)
        .parentList
        .data!.data!.length;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        pageValueController.displayItems < totalItem) {
      if(kDebugMode){
        // print("Page down");
      }
      // Load more items if we haven't displayed all
      setState(() {
        pageValueController.displayItems += totalItem - pageValueController.displayItems>10? 10 :totalItem - pageValueController.displayItems; // Load 10 more items
      });
    }
  }

  bool isAullParentList = true;



  @override
  void initState() {
    super.initState();
    // _getToken();
    WidgetsBinding.instance.addObserver(this);
    _checkInitialization();
    // Subscribe to connection status changes
    Get.find<NetworkController>().connectionStatusStream.listen((isConnected) {
      if (isConnected) {
        _checkInitialization();
      } else {
        // Optionally handle when the internet is lost
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _setFirstRunTrue();
    }
  }

  Future<void> _checkInitialization() async {
    bool isConnected = await Get.find<NetworkController>().isConnected();
    // print("internetconnectioncheck0 $isConnected");

    if(kIsWeb){
      pageValueController.displayItems = 10;
      _scrollController.addListener(_onScroll);
    }
    if (isConnected) {
      pageValueController.displayItems = 10;
      _scrollController.addListener(_onScroll); // Listen for scroll events
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
      if (isFirstRun) {
        pageValueController.filterParent = false;
        await initFunction();
        await prefs.setBool('isFirstRun', false);
      }
    }
    // else{
    //   Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noInternetConnection, Icons.error, Colors.red, context);
    // }

    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
      if (isFirstRun) {
        pageValueController.filterParent = false;
        await initFunction();
        await prefs.setBool('isFirstRun', false);
      }
    }
    // else{
    //   Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noInternetConnection, Icons.error, Colors.red, context);
    // }
  }

  Future<void> _setFirstRunTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', true);
    await prefs.setBool('isChildRun', true);
  }

  Future<void> initFunction() async {
    if (pageValueController.parentPageValue == Constant.filterParentPageValue) {
      isAullParentList = false;


      String additionUrl ="";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        parentListViewModel =
            Provider.of<ExpenseListViewModel>(context, listen: false);
        parentListViewModel.getParentApi(context, additionUrl);
      });
      params.clear();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        parentListViewModel =
            Provider.of<ExpenseListViewModel>(context, listen: false);
        parentListViewModel.getParentApi(context, additionUrl);
      });
    }
    pageValueController.filterParent = false;
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Scaffold(
        backgroundColor: AppColors.screenBGColor,
        body: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.07,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (isAullParentList)
                Text(
                  AppLocalizations.of(context)!.petApp,
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      // fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.bold),
                ),
              if (isAullParentList)
                Row(
                  children: [
                    Text(
                      "List of users expenses",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap: () {
                        pageValueController.addPhotoPageValue = addPhotoPage;
                        Navigator.pushNamed(
                          context,
                          RoutesName.parent_entry,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.activeBGColor,
                        radius: 26,
                        child: Image.asset(
                          ImageAssets.plusIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              // SizedBox(height: 10),
              Consumer<ExpenseListViewModel>(
                builder: (context, parentListViewModel, _) {
                  if (parentListViewModel.parentList.status == Status.LOADING) {
                    return _buildShimmerList();
                  } else if (parentListViewModel.parentList.status ==
                      Status.COMPLETED) {
                    var parentListData =
                        parentListViewModel.parentList.data?.data ?? [];

                    if (parentListData.isEmpty) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 100),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.noData,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        backgroundColor: AppColors.activeBGColor,
                        color: AppColors.whiteColor,
                        onRefresh: () {
                          return Future.delayed(
                            Duration(seconds: 1),
                            () {
                              setState(() {
                                pageValueController.displayItems = 10;
                                initFunction();
                              });
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              child: ListView.builder(

                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.01),
                                controller: _scrollController,
                                itemCount: pageValueController.displayItems < parentListData.length
                                    ? pageValueController.displayItems
                                    :  parentListData.length,
                                // itemCount: parentListData.length,
                                itemBuilder: (context, index) {
                                  final expense = parentListData[index];

                                  return Card(
                                    elevation: 0,
                                    margin: EdgeInsets.all(5),
                                    color: AppColors.gray2Color // Set the color to gray if all conditions are true
                                        , // Otherwise, set the color to white

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        expenseController.user_id= expense.skUserId;
                                        expenseController.product_name.text= expense.productName!;
                                        expenseController.expense_amount.text= expense.expenseAmount!;
                                        expenseController.expense_date= expense.timeOfUse.toString();

                                          // Set the parent ID and navigate to the parent details page
                                          userIdController.parentId = expense.pkExpenseId.toString();
                                          pageValueController.detailsOrConfirmOverview = Constant.detailsPage;
                                          pageValueController.parent_user_id = expense.skUserId.toString();
                                          pageValueController.parentDetailsPageValue = Constant.parentListToParent;
                                          Navigator.pushNamed(context, RoutesName.pet_details);

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),

                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    expense.productName ?? "",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.009),
                                                  Row(
                                                    children: [
                                                      CustomContainer(
                                                        text: AppLocalizations
                                                                .of(context)!
                                                            .managementNumber,
                                                        backgroundColor:
                                                            AppColors
                                                                .lightGrayColor,
                                                      ),
                                                      SizedBox(
                                                          width: kIsWeb
                                                              ? (screenWidth >
                                                                      Constant
                                                                          .mobileBreakpoint
                                                                  ? screenWidth *
                                                                      0.01
                                                                  : screenWidth *
                                                                      0.9)
                                                              : screenWidth *
                                                                  0.03),
                                                      AutoSizeText(

                                                        expense.timeOfUse.isNull ?"":DateFormat('dd-MM-yyyy').format(DateTime.parse(expense.timeOfUse.toString())),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.005),
                                                  Row(
                                                    children: [
                                                      CustomContainer(
                                                        text:"Amount",
                                                        backgroundColor:
                                                            AppColors
                                                                .lightGrayColor,
                                                      ),
                                                      SizedBox(
                                                          width: kIsWeb
                                                              ? (screenWidth >
                                                                      Constant
                                                                          .mobileBreakpoint
                                                                  ? screenWidth *
                                                                      0.01
                                                                  : screenWidth *
                                                                      0.9)
                                                              : screenWidth *
                                                                  0.03),
                                                      AutoSizeText(
                                                        expense.expenseAmount.toString() ??
                                                            "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.005),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: AppColors.grayLineColor),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (parentListViewModel.parentList.status ==
                      Status.ERROR) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 100),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.noData,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    var screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: screenHeight * 0.01),
        itemCount: 5, // Number of shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: screenHeight * 0.20, // Adjust height as per your design
            ),
          );
        },
      ),
    );
  }


}
