// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p_1/image_viewer/image_zooming.dart';

class ImageScreenModel {
  final List<String> imageList;
  final int tappedIndex;
  final List<String>? title;
  ImageScreenModel({required this.imageList, this.tappedIndex = 0, this.title});
}

class CustomImagePreviewScreen extends StatefulWidget {
  final ImageScreenModel images;
  const CustomImagePreviewScreen({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<CustomImagePreviewScreen> createState() =>
      _CustomImagePreviewScreenState();
}

class _CustomImagePreviewScreenState extends State<CustomImagePreviewScreen> {
  PageController _controller = PageController();
  late ValueNotifier<int> _currentImageIndex;
  final ValueNotifier<bool> _isZoomed = ValueNotifier<bool>(false);
  int imageIndex = 0;

  @override
  void initState() {
    _currentImageIndex = ValueNotifier(widget.images.tappedIndex + 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_controller.hasClients && widget.images.tappedIndex != 0) {
        _controller.animateToPage(widget.images.tappedIndex,
            duration: Duration(microseconds: 1), curve: Curves.easeIn);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: _isZoomed,
                builder: (context, zoomed, _) {
                  return PageView.builder(
                    itemCount: widget.images.imageList.length,
                    physics: zoomed
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (i) {
                      _currentImageIndex.value = i + 1;
                    },
                    itemBuilder: (context, index) {
                      imageIndex = index;
                      return Center(
                        child: DoubleTappableInteractiveViewer(
                            callBack: (isZoomed) => _isZoomed.value = isZoomed,
                            scaleDuration: const Duration(milliseconds: 600),
                            child: CachedNetworkImage(
                              height: MediaQuery.of(context).size.height * 0.9,
                              placeholder: (context, url) => Image.network(
                                "https://placehold.co/600x400/png",
                                fit: BoxFit.fitWidth,
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                "https://placehold.co/600x400/png",
                                fit: BoxFit.fitWidth,
                              ),
                              imageUrl: widget.images.imageList[index],
                            )),
                      );
                    },
                  );
                }),
            Padding(
              padding: EdgeInsets.only(
                right: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  if (widget.images.title != null) ...{
                    ValueListenableBuilder(
                      valueListenable: _currentImageIndex,
                      builder: (_, currI, child) {
                        return Expanded(
                          child: Text(
                            widget.images.title![currI - 1],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                ),
                          ),
                        );
                      },
                    )
                  },
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
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
                        valueListenable: _currentImageIndex,
                        builder: (c, currentImageIndex, _) {
                          return RichText(
                            text: TextSpan(
                              text: currentImageIndex.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: ' / ',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                TextSpan(
                                  text:
                                      widget.images.imageList.length.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
