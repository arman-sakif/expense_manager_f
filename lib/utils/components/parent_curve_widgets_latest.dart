import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_details_controller.dart';
import '../../res/app_color.dart';
import '../functions/image_functions.dart';

class ParentsCurveWidgetsLatest extends StatefulWidget {
  final List<dynamic> imgList;

  ParentsCurveWidgetsLatest({required this.imgList});

  @override
  _ParentsCurveWidgetsLatestState createState() => _ParentsCurveWidgetsLatestState();

}

class _ParentsCurveWidgetsLatestState extends State<ParentsCurveWidgetsLatest> {
  final CarouselSliderController _controller = CarouselSliderController();
  final ExpenseController parentDetailsController = Get.put(ExpenseController());
  ImageManager imageManager = ImageManager();
  int _current = 0;

  List<Widget> get imageSliders {
    return widget.imgList.map((item) {
      return Container(
        child: imageManager.loadImage(
          item,
          double.infinity,  // Use the width based on your layout needs
          MediaQuery.of(context).size.height * 0.3, // Adjust height as needed
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: AppColors.lightBGColor,
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: widget.imgList.length > 1,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0, // Ensure full width
                        enableInfiniteScroll: widget.imgList.length > 1,  // Allow infinite scroll only if more than one image
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.imgList.length > 1)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
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
        ],
      ),
    );
  }
}
