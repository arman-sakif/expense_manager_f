import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/page_value_controller.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../utils.dart';
import 'buttonComponents/custom_rounded_btn.dart';
import 'textComponents/custom_contrainer_textview.dart';
import 'textComponents/custom_textview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class childCurveWidgets extends StatefulWidget {
  final Widget aboutChild,motherChild,fatherChild,birthChild,fifteenDaysChild,thirtyDaysChild,fortyFiveDaysChild;
  final List<String> imgList;

  childCurveWidgets({ required this.imgList,required this.aboutChild,required this.motherChild,required this.fatherChild,
    required this.birthChild,required this.fifteenDaysChild,required this.thirtyDaysChild,required this.fortyFiveDaysChild});

  @override
  _childCurveWidgetsState createState() => _childCurveWidgetsState();
}

class _childCurveWidgetsState extends State<childCurveWidgets> {
  final CarouselSliderController _controller = CarouselSliderController();
  PageValueController pageValueController = Get.put(PageValueController());
  int _current = 0;
  late bool visibleGrowthValue;



  List<Widget> get imageSliders {
    return widget.imgList.map((item) => Container(
      child: Image.network(item, fit: BoxFit.cover,width: double.infinity,
      ),
    )).toList();
  }

  @override
  void initState() {
    visibleGrowthValue = pageValueController.childButtonVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        // aspectRatio: 24.0,
                        height: MediaQuery.of(context).size.width*0.58,
                        viewportFraction: 1.0, // Ensure full width
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height *.76,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                                  .withOpacity(_current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                child: IconButton(
                  icon: Image.asset(
                    ImageAssets.backButton, // Change this to your actual asset path
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Handle back button press
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *.25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      aboutWhiteCard(context, widget.aboutChild),
                      spaceHeight(context: context, size: 20),
                      motherWhiteCard(context, widget.motherChild),
                      spaceHeight(context: context, size: 20),
                      fatherWhiteCard(context, widget.fatherChild),
                      spaceHeight(context: context, size: 20),
                      birthWhiteCard(context, widget.birthChild),
                      spaceHeight(context: context, size: 20),
                      fifteenDaysWhiteCard(context, widget.fifteenDaysChild),
                      spaceHeight(context: context, size: 20),
                      thirtyDaysWhiteCard(context, widget.thirtyDaysChild),
                      spaceHeight(context: context, size: 20),
                      fortyFiveDaysWhiteCard(context, widget.fortyFiveDaysChild),
                      spaceHeight(context: context, size: 20),

                      Visibility(
                          visible: visibleGrowthValue,
                          child: CustomButton(text: AppLocalizations.of(context)!.downloadPhoto, onPressed: (){})),
                      spaceHeight(context: context, size: 5),
                      Visibility(
                          visible: visibleGrowthValue,
                          child: CustomButton(text: AppLocalizations.of(context)!.downloadParent, onPressed:  (){})),
                      spaceHeight(context: context, size: 5),
                      Visibility(
                          visible: visibleGrowthValue,
                          child: CustomButton(text: AppLocalizations.of(context)!.downloadRecord, onPressed: (){})),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget aboutWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.35,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget motherWhiteCard(BuildContext context, Widget widget) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.4,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget fatherWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.4,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget birthWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget fifteenDaysWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget thirtyDaysWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
  Widget fortyFiveDaysWhiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.3,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(Radius.circular(30)
        ),
      ),
      child: widget,
    );
  }
}