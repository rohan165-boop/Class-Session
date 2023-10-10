// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_zooming.dart';

class ImageView extends StatefulWidget {
  final ValueNotifier<int> imageIndex;
  final ValueNotifier<bool> viewImage;
  final ValueNotifier<bool> isZoomed;
  final List<String> imageList;
  const ImageView({
    Key? key,
    required this.imageIndex,
    required this.viewImage,
    required this.isZoomed,
    required this.imageList,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: widget.viewImage,
            builder: (context, imageStatus, _) {
              return ValueListenableBuilder(
                  valueListenable: widget.imageIndex,
                  builder: (context, imageIndex, _) {
                    return Visibility(
                        visible: imageStatus,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: MediaQuery.of(context).size.height * 0.8,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //===
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          5.r,
                                        ),
                                      ),
                                    ),
                                    child: ValueListenableBuilder<int>(
                                        valueListenable: widget.imageIndex,
                                        builder: (c, currentImageIndex, _) {
                                          return RichText(
                                            text: TextSpan(
                                              text: (currentImageIndex + 1)
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                  text: ' / ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                TextSpan(
                                                  text: widget.imageList.length
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),

                                  /// cancle button
                                  20.horizontalSpace,

                                  InkWell(
                                    onTap: () {
                                      widget.viewImage.value =
                                          !widget.viewImage.value;
                                      // locator<NavigationService>().goBack();
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 40.w,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              10.verticalSpace,
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: widget.isZoomed,
                                        builder: (context, zoomed, _) {
                                          return DoubleTappableInteractiveViewer(
                                            callBack: (isZoomed) => widget
                                                .isZoomed.value = isZoomed,
                                            scaleDuration: const Duration(
                                                milliseconds: 600),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  widget.imageList[imageIndex],
                                            ),
                                          );
                                        }),
                                    Row(
                                      children: [
                                        if (imageIndex != 0)
                                          IconButton(
                                              onPressed: () {
                                                if (imageIndex != 0) {
                                                  widget.imageIndex.value -= 1;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.red,
                                                size: 30.w,
                                              )),
                                        Spacer(),
                                        if (imageIndex !=
                                            (widget.imageList.length - 1))
                                          IconButton(
                                              onPressed: () {
                                                if (imageIndex !=
                                                    (widget.imageList.length -
                                                        1)) {
                                                  widget.imageIndex.value += 1;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.red,
                                                size: 30.w,
                                              )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            }),
      ),
    );
  }
}
