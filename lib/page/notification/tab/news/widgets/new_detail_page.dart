import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/page/product/detail/widgets/widgets/review_file.dart';
import 'package:eco_app/resources/routes.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:eco_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewDetailPage extends StatefulWidget {
  const NewDetailPage({super.key});

  @override
  _NewDetailPageState createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage> {
  final List<String> imageUrls = [
    'https://media.gettyimages.com/id/1786520946/photo/london-england-general-view-of-the-drinks-reception-after-the-bafta-masterclass-held-at-bafta.jpg?s=612x612&w=0&k=20&c=pXuHg289JYMBujc4yHVH2MKuW6NIjAnZPSJNNUCqef0=',
    'https://media.gettyimages.com/id/57487230/photo/now-rally-for-womens-rights-in-iran-outside-st-patricks-cathedral.jpg?s=612x612&w=0&k=20&c=Au-urYyQzEvhZ2VmlGQikx1NesjrDTqBOgLGd58wkFA=',
    'https://media.gettyimages.com/id/2021044233/photo/london-england-prince-william-prince-of-wales-meets-phoebe-dynevor-ayo-edebiri-sophie-wilde.jpg?s=612x612&w=0&k=20&c=xkiOnc6Si2V4vOh82guGtg1y6RwVDrON9AmUfOjCmds=',
  ];
  final FocusNode _focusNode = FocusNode();
  int currentIndex = 0;

  bool isSetting = false;
  final controller = PageController(keepPage: true);

  bool listenBox = false;

  late ScrollController _hideBottomAppBarController;

  int length = 0;

  @override
  void initState() {
    super.initState();

    _hideBottomAppBarController = ScrollController();
  }

  @override
  void dispose() {
    _hideBottomAppBarController.dispose();
    super.dispose();
  }

  bool showAllComments = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: BackButton(
          //   color: colorWhite,
          //   onPressed: () {
          //     context.justBack();
          //   },
          // ),
          backgroundColor: colorMain,
          title: Text(
            'Tin tức',
            style: textTheme.titleMedium?.copyWith(
              color: colorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _hideBottomAppBarController,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: PageView.builder(
                        itemCount: imageUrls.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ReviewFiles.show(
                                context,
                                filesUrl: imageUrls,
                                initIndex: index,
                                onDelete: (index) {
                                  // uploader.removeFileAtValue(
                                  //     imageFiles[index], state.domainApi);
                                },
                              );
                            },
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    spaceH6,
                    Container(
                      color: colorWhite,
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'As the official case against Assange stagnates, an international movement to free him has only grown stronger',
                                        maxLines: null,
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorGray05,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('March 7, 2024',
                                        style: textTheme.bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: colorGray03,
                    ),
                    Row(
                      children: <Widget>[
                        spaceW12,
                        Expanded(
                          child: Text(
                            'By Kevin Gosztola In March 2023, when my book on the case against Julian Assange was published, the detained WikiLeaks founder was waiting to find out if an appeals court in London would allow him to appeal extradition to the United States.Now, Guilty of Journalism: The Political Case Against Julian Assange has been available on bookshelves for one year—and Assange still does not know if he has permission to appeal.Such limbo has developed into a feature of the prosecution against Assange. The march of time whittles away at Assange while cold-blooded authorities keep him in arbitrary detention Assange was 38 years of age when WikiLeaks garnered praise for publishing disclosures from US Army whistleblower Chelsea Manning. Assange was an ardent, nimble, and sharp-witted advocate for the truth. But at 52, Assange is increasingly frail as delays in proceedings compound physical and mental health problems that he must endure in Belmarsh prison.President Joe Biden’s administration may prefer the limbo to an unprecedented trial that will invite global condemnation. No Biden official has expressed any reservations when it comes to charging Assange. ',
                            maxLines: null,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorGray04,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceH16,
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: PageView.builder(
                            controller: controller,
                            itemCount: imageUrls.length,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  ReviewFiles.show(
                                    context,
                                    filesUrl: imageUrls,
                                    initIndex: index,
                                    onDelete: (index) {
                                      // uploader.removeFileAtValue(
                                      //     imageFiles[index], state.domainApi);
                                    },
                                  );
                                },
                                child: Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        spaceH10,
                        SmoothPageIndicator(
                          controller: controller, // PageController
                          count: imageUrls.length,
                          effect: WormEffect(
                            activeDotColor: context.theme.primaryColor,
                            dotColor: context.theme.secondaryHeaderColor,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                          onDotClicked: (index) {},
                        ),
                      ],
                    ),
                    spaceH16,
                    Row(
                      children: <Widget>[
                        spaceW12,
                        Expanded(
                          child: Text(
                            'By Kevin Gosztola In March 2023, when my book on the case against Julian Assange was published, the detained WikiLeaks founder was waiting to find out if an appeals court in London would allow him to appeal extradition to the United States.Now, Guilty of Journalism: ',
                            maxLines: null,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorGray04,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceH20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _newsWidget(
                            context,
                            title: "Tin tức liên quan",
                            isTimer: false,
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 0),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  routeService.pushNamed(
                                    Routes.newDetailPage,
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    spaceH16,
                                    Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        'By Kevin Gosztola In March 2023, when my book on the case By Kevin Gosztola In March 2023, when my book on the case when my book on the case ',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorBlack,
                                            fontWeight: FontWeight.bold)),
                                    spaceH8,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.all(6.r),
                                            child: Image.network(
                                              'https://images2.thanhnien.vn/zoom/328_205/Uploaded/linhntqc/2023_01_21/picture1-7887.jpg',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        maxLines: null,
                                                        'Chi nhánh 1519 Phạm Văn Thuận TP Biên Hoà Đồng Nai, Việt Nam',
                                                        style: textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ),
                                                ],
                                              ),
                                              spaceH8,
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        maxLines: null,
                                                        'CN 1519 Phạm Văn Thuận TP Biên Hoà',
                                                        style: textTheme
                                                            .bodySmall),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('01-12-2023',
                                            style: textTheme.bodySmall),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.grey,
                              thickness: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH72,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsWidget(
    BuildContext context, {
    required final String title,
    required bool isTimer,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: colorPrimary)),
      ],
    );
  }
}
