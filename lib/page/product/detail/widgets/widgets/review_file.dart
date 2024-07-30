import 'package:cached_network_image/cached_network_image.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReviewFiles extends StatefulWidget {
  const ReviewFiles({
    super.key,
    required this.filesUrl,
    required this.initIndex,
    this.imageScripts,
    this.onDelete,
  });

  final List<String> filesUrl;
  final int initIndex;
  final void Function(int)? onDelete;
  final List<String>? imageScripts;

  static void show(
    BuildContext context, {
    required List<String> filesUrl,
    List<String>? imageScripts,
    int? initIndex,
    void Function(int)? onDelete,
  }) {
    showDialog<void>(
      barrierColor: colorBlack,
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return ReviewFiles(
          imageScripts: imageScripts,
          filesUrl: filesUrl,
          initIndex: initIndex ?? 0,
          onDelete: onDelete,
        );
      },
    );
  }

  @override
  State<ReviewFiles> createState() => _ReviewFilesState();
}

class _ReviewFilesState extends State<ReviewFiles> {
  late PageController controller;
  late int currentPage;
  late List<String> filesUrl;
  late List<String>? imageScripts;
  @override
  void initState() {
    super.initState();

    // imageScripts = List.generate(
    //   filesUrl.length,
    //   (index) => "${index + 1}",
    // );
    imageScripts = widget.imageScripts;
    currentPage = widget.initIndex;
    filesUrl = widget.filesUrl;
    controller = PageController(
      initialPage: currentPage,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
                allowImplicitScrolling: true,
                itemCount: filesUrl.length,
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (BuildContext context, index) {
                  // if (filesUrl[index].fileFormat == 'image') {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: CachedNetworkImage(
                      imageUrl: filesUrl[index],
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                  // }
                  // return ViewVideo(
                  //   videoUrl: filesUrl[index].filePath ?? '',
                  //   isCustomUI: true,
                  // );
                }),
          ),
          Visibility(
            visible: filesUrl.length != 1,
            child: Positioned.fill(
              bottom: 40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  textDirection: TextDirection.ltr,
                  controller: controller, // PageController
                  count: filesUrl.length,
                  effect: WormEffect(
                    activeDotColor: context.theme.primaryColor,
                    dotColor: context.theme.secondaryHeaderColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ), // your preferred effect
                  onDotClicked: (index) {},
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Center(
              child: Text(
                imageScripts == null ? '' : imageScripts![currentPage],
                style: textTheme.titleMedium?.copyWith(
                  color: colorWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.back<void>();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Text(
                            'Đóng',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
