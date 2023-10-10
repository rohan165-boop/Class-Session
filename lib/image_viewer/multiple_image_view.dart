import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import 'full_image_view.dart';

class CustomMultipleImageViewWidget extends StatefulWidget {
  final List<String> images;
  const CustomMultipleImageViewWidget({
    super.key,
    this.images = const [],
  });

  @override
  State<CustomMultipleImageViewWidget> createState() =>
      _CustomMultipleImageViewWidgetState();
}

class _CustomMultipleImageViewWidgetState
    extends State<CustomMultipleImageViewWidget> {
  List<String> imageList = [
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/200",
    "https://picsum.photos/id/870/200/300?grayscale&blur=2",
    "https://picsum.photos/200/300?random=1",
    "https://picsum.photos/200/300?random=2",
  ];

  PageController _controller = PageController();

  final ValueNotifier<double> _aspectRatio = ValueNotifier<double>(1.0);
  final ValueNotifier<int> _imageIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _viewImage = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isZoomed = ValueNotifier<bool>(false);
  @override
  void initState() {
    if (widget.images.isNotEmpty) {
      imageList = widget.images;
    }
    setAspectRatio();

    // _imageIndex.value = ValueNotifier(_imageIndex.value + 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_controller.hasClients && _imageIndex.value != 0) {
        _controller.animateToPage(_imageIndex.value,
            duration: Duration(microseconds: 1), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  ///========  set the aspect ratio of Image ========
  void setAspectRatio() {
    if (imageList.length == 1) {
      _aspectRatio.value = 1.5;
    } else if (imageList.length == 2) {
      _aspectRatio.value = 0.75;
    } else if (imageList.length == 3) {
      _aspectRatio.value = 1.55;
    } else if (imageList.length >= 4) {
      _aspectRatio.value = 1.55;
    }
  }

  ///============ redirection to Image viewer screen =================
  void reDirectToImageScreen({required int index}) {
    _viewImage.value = !_viewImage.value;
    _imageIndex.value = index;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageView(
                  imageList: imageList,
                  imageIndex: _imageIndex,
                  viewImage: _viewImage,
                  isZoomed: _isZoomed,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _viewImage,
        builder: (context, imageStatus, _) {
          return ValueListenableBuilder(
              valueListenable: _imageIndex,
              builder: (context, imageIndex, _) {
                return Stack(
                  children: [
                    Visibility(
                      visible: !imageStatus,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.red,
                        )),
                        child: ValueListenableBuilder(
                            valueListenable: _aspectRatio,
                            builder: (context, aspectRatioValue, _) {
                              return Wrap(
                                spacing: 5.w,
                                runSpacing: 5.h,
                                children: [
                                  if (imageList.length >= 1) ...[
                                    SizedBox(
                                      width: imageList.length != 1
                                          ? MediaQuery.of(context).size.width *
                                              0.4
                                          : double.infinity,
                                      child: imageView(
                                          image: imageList.first,
                                          index: 0,
                                          aspectRatio: aspectRatioValue),
                                    ),
                                  ],
                                  if (imageList.length >= 2) ...[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: imageView(
                                          image: imageList[1],
                                          index: 1,
                                          aspectRatio: aspectRatioValue),
                                    ),
                                  ],
                                  if (imageList.length >= 3) ...[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: imageView(
                                          image: imageList[2],
                                          index: 2,
                                          aspectRatio: aspectRatioValue),
                                    ),
                                  ],
                                  if (imageList.length > 3) ...[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          imageView(
                                              image: imageList[3],
                                              index: 3,
                                              aspectRatio: aspectRatioValue),

                                          // The glass effect overlay
                                          BackdropFilter(
                                            filter: ui.ImageFilter.blur(
                                                sigmaX: 0, sigmaY: 0),
                                            child: InkWell(
                                              onTap: () =>
                                                  reDirectToImageScreen(
                                                      index: 3),
                                              child: AspectRatio(
                                                aspectRatio: aspectRatioValue,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.435,
                                                  color: Colors.black.withOpacity(
                                                      0.5), // Adjust the opacity as desired
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "+ ${imageList.length - 3}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  Widget imageView({
    required String image,
    required int index,
    double? width,
    double? height,
    double? aspectRatio,
  }) {
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1.0,
      child: InkWell(
        onTap: () => reDirectToImageScreen(index: index),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
