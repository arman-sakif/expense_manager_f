import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';


class parentsCurveWidgets extends StatefulWidget {
  final Widget child;
  final List<XFile> imgList;
  final List<String>? imgStringList;

  parentsCurveWidgets({required this.child, required this.imgList, this.imgStringList });

  @override
  _parentsCurveWidgetsState createState() => _parentsCurveWidgetsState();
}

class _parentsCurveWidgetsState extends State<parentsCurveWidgets> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;


  // final List<String> imgList = [
  //   ImageAssets.dogImage,
  //   ImageAssets.catImage,
  //   ImageAssets.singleDog,
  // ];

  // List<Widget> get imageSliders {
  //   return widget.imgList!.map((item) => Container(
  //     // width: double.infinity,
  //     child: Image.asset(item, fit: BoxFit.cover,width: double.infinity,
  //     ),
  //   )).toList();
  // }


  List<Widget> get imageSliders {
  return widget.imgStringList != null  ?

  widget.imgStringList!.map((item) => Container(
    // width: double.infinity,
    child: Image.network(item, fit: BoxFit.cover,width: double.infinity,
    ),
  )).toList() :
    widget.imgList.map((item) => Container(
  // width: double.infinity,
  child: Image.file( File(item.path) , fit: BoxFit.cover,width: double.infinity,
  ))).toList();
  }

  // List<Widget> get imageSliders {
  //   return widget.imgStringList!.isNotEmpty
  //       ? widget.imgStringList!
  //       .map((item) => GestureDetector(
  //     onTap: () => _navigateToZoomView(widget.imgStringList!, widget.imgStringList!.indexOf(item)),
  //     child: Container(
  //       child: Image.network(
  //         item,
  //         fit: BoxFit.cover,
  //         width: double.infinity,
  //       ),
  //     ),
  //   ))
  //       .toList()
  //       : widget.imgList
  //       .map((item) => GestureDetector(
  //     onTap: () => _navigateToZoomView(widget.imgList.map((file) => file.path).toList(), widget.imgList.indexOf(item)),
  //     child: Container(
  //       child: Image.file(
  //         File(item.path),
  //         fit: BoxFit.cover,
  //         width: double.infinity,
  //       ),
  //     ),
  //   ))
  //       .toList();
  // }
  // void _navigateToZoomView(List<String> imageList, int initialIndex) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ZoomableImageView(
  //         imageList: imageList,
  //         initialIndex: initialIndex,
  //       ),
  //     ),
  //   );
  // }

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
                    child: Container(
                      color: AppColors.lightBGColor,
                      child: CarouselSlider(
                        items: imageSliders,
                        // carouselController: _controller,
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          // aspectRatio: 24.0,
                          height: MediaQuery.of(context).size.width*0.56,
                          viewportFraction: 1.0, // Ensure full width
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height *.76,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:widget.imgStringList != null  ?

                      widget.imgStringList!.asMap().entries.map((entry) {
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
                      }).toList() :

                      widget.imgList!.asMap().entries.map((entry) {
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
              child: whiteCard(context, widget.child),
            ),
          ],
        ),
      ),
    );
  }

  Widget whiteCard(BuildContext context, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black,
        //     offset: Offset(0, 1), // changes the position of the shadow
        //     blurRadius: 3.0,
        //   ),
        // ],
      ),
      child: widget,
    );
  }
}

class ZoomableImageView extends StatelessWidget {
  final List<String> imageList;
  final int initialIndex;

  ZoomableImageView({required this.imageList, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoomable Image'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imageList[index].startsWith('http')
                ? NetworkImage(imageList[index])
                : FileImage(File(imageList[index])) as ImageProvider,
            initialScale: PhotoViewComputedScale.contained * 1.0,
            minScale: PhotoViewComputedScale.contained * 1.0,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          );
        },
        pageController: PageController(initialPage: initialIndex),
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
// child: CarouselSlider(
//   options: CarouselOptions(),
//   items: imgList
//       .map((item) => Container(
//     child: Center(
//       child: Image.asset(item,
//           fit: BoxFit.cover, width: double.infinity),
//     ),
//   ))
//       .toList(),
// )