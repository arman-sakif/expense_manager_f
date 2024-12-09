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
import 'package:syncfusion_flutter_charts/charts.dart';
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

class StatsPage extends StatefulWidget {
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with WidgetsBindingObserver {
  @override

  String additionUrl = "";
  List<String> params = [];


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

    if(kIsWeb){
      pageValueController.displayItems = 10;
      _scrollController.addListener(_onScroll);
    }
    if (isConnected) {
      pageValueController.displayItems = 10;
      _scrollController.addListener(_onScroll); // Listen for scroll events
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstRun = prefs.getBool('isChildRun') ?? true;
      if (isFirstRun) {
        pageValueController.filterParent = false;
        await initFunction();
        await prefs.setBool('isChildRun', false);
      }
    }
    // else{
    //   Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noInternetConnection, Icons.error, Colors.red, context);
    // }

    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstRun = prefs.getBool('isChildRun') ?? true;
      if (isFirstRun) {
        pageValueController.filterParent = false;
        await initFunction();
        await prefs.setBool('isChildRun', false);
      }
    }

  }

  Future<void> _setFirstRunTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', true);
    await prefs.setBool('isChildRun', true);
  }

  Future<void> initFunction() async {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        parentListViewModel =
            Provider.of<ExpenseListViewModel>(context, listen: false);
        parentListViewModel.getMonthlyExpenseApi(context, additionUrl);
      });

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



              SizedBox(
                  height:
                  screenHeight * 0.005),
                Row(
                  children: [
                    Text(
                      "Monthly Expense Overview",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),


                  ],
                ),


              SizedBox(
                  height:
                  screenHeight * 0.005),
              // SizedBox(height: 10),
              Consumer<ExpenseListViewModel>(
                builder: (context, parentListViewModel, _) {
                  if (parentListViewModel.parentList.status == Status.LOADING) {
                    return _buildShimmerList();
                  } else if (parentListViewModel.monthlyExpense.status == Status.COMPLETED) {
                    var monthlyExpenseData = parentListViewModel.monthlyExpense.data?.data;

                    // Extract the required data from the model
                    double totalExpense = monthlyExpenseData?.totalExpense ?? 0.0;
                    Map<String, double> expenseDistribution = monthlyExpenseData?.expenseDistribution ?? {};

                    return Expanded(
                      child: RefreshIndicator(
                        backgroundColor: AppColors.activeBGColor,
                        color: AppColors.whiteColor,
                        onRefresh: () {
                          return Future.delayed(
                            Duration(seconds: 1),
                                () {
                              setState(() {
                                initFunction();
                              });
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                screenHeight * 0.005),
                            // Display total expense
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Total Expense: \$${totalExpense.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                            // Display expense distribution as a list
                            Expanded(
                              child: SfCircularChart(
                                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                                series: <CircularSeries>[
                                  // Pie chart series using dynamic expenseDistribution data
                                  PieSeries<MapEntry<String, double>, String>(
                                    dataSource: expenseDistribution.entries.toList(),  // Convert the map to a list of MapEntry
                                    xValueMapper: (MapEntry<String, double> data, _) => data.key,
                                    yValueMapper: (MapEntry<String, double> data, _) => data.value,
                                    dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (parentListViewModel.parentList.status == Status.ERROR) {
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
        itemCount: 1, // Number of shimmer items
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
