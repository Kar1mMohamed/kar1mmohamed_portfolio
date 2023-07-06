import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kar1mmohamed_portfolio/data/assets.dart';
import 'package:kar1mmohamed_portfolio/data/comapny_module.dart';
import 'package:kar1mmohamed_portfolio/data/contact_module.dart';
import 'package:kar1mmohamed_portfolio/extensions/size.dart';
import 'package:kar1mmohamed_portfolio/utils/responsive_layout.dart';

import '../../widgets/textfield.dart';

/// 0 => first section
/// 1 => second section
/// 2 => third section
final sectionsKeys = List.generate(3, (index) => GlobalKey());
int currentSectionIndex = 0;
final compaines = [
  CompanyModule(
    name: 'Vision',
    logoAsset: Assets.visionLogo,
  ),
  CompanyModule(
    name: 'Ghaier',
    logoAsset: Assets.ghaierLogo,
  ),
  CompanyModule(
    name: 'Karim Hassan',
    logoAsset: Assets.karimHassanLogo,
  ),
  CompanyModule(
    name: 'Edu Zone',
    logoAsset: Assets.eduZoneLogo,
  ),
  CompanyModule(
    name: 'Mataajer Saudi',
    logoAsset: Assets.mataajerSaLogo,
  ),
  CompanyModule(
    name: 'Sherif Awad',
    logoAsset: Assets.sherifAwadLogo,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  bool isArrowDown = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final currentPosition = scrollController.position.pixels;
      final lastScreenBox = sectionsKeys[sectionsKeys.length - 1]
          .currentContext!
          .findRenderObject() as RenderBox?;

      final lastScreenPosition = lastScreenBox!.localToGlobal(Offset.zero).dy;

      if (currentPosition >= lastScreenPosition) {
        setState(() {
          isArrowDown = false;
        });
      } else if (currentSectionIndex == 0) {
        setState(() {
          isArrowDown = true;
        });
      } else if (currentSectionIndex > 0 &&
          currentSectionIndex < sectionsKeys.length - 1) {
        setState(() {
          isArrowDown = true;
        });
      } else if (currentSectionIndex > 0 &&
          currentSectionIndex == sectionsKeys.length - 1) {
        setState(() {
          isArrowDown = false;
        });
      }

      log('currentSectionIndex: $currentSectionIndex, isArrowDown: $isArrowDown');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log('currentSectionIndex: $currentSectionIndex');
          currentSectionIndex++;
          if (currentSectionIndex > 2) {
            currentSectionIndex = 0;
            setState(() {});
          }
          log('moving to: $currentSectionIndex');

          Scrollable.ensureVisible(
            sectionsKeys[currentSectionIndex].currentContext!,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );

          // if (currentSectionIndex == 0) {
          //   setState(() {
          //     isArrowDown = true;
          //   });
          // } else if (currentSectionIndex > 0 &&
          //     currentSectionIndex != sectionsKeys.length - 1) {
          //   setState(() {
          //     isArrowDown = true;
          //   });
          // } else if (currentSectionIndex > 1 &&
          //     currentSectionIndex == sectionsKeys.length - 1) {
          //   setState(() {
          //     isArrowDown = false;
          //   });
          // }
        },
        backgroundColor: Colors.black,
        child: Icon(
          isArrowDown ? Icons.arrow_downward : Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ResponsiveLayout(
        largeScreen: _LargeScreen(scrollController: scrollController),
        smallScreen: SmallScreen(scrollController: scrollController),
      ),
    );
  }
}

class _LargeScreen extends StatefulWidget {
  const _LargeScreen({required this.scrollController});

  final ScrollController scrollController;

  @override
  State<_LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<_LargeScreen> {
  double fourthHeight = 50;
  double fourthWidth = 150;
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final messageC = TextEditingController();

  String? thanksMessage;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            firstSection(context),
            secondSection(context),
            thirdSection(context),
            fourthSection(context),
          ],
        ),
      ),
    );
  }

  Widget firstSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[0],
      height: context.height,
      width: context.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          image(context),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: context.width * 0.1),
              child: Text(
                'Karim \nMohamed',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'Stinger',
                      fontSize: 100.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget secondSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[1],
      height: context.height,
      width: context.width,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Your partner to implement your ideas.',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontFamily: 'Stinger',
                  fontSize: 50.w * 0.4,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  Widget thirdSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[2],
      height: context.height,
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.height * 0.05),
          Text(
            'My clients are my partners. I work with them to achieve results they can measure.',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontFamily: 'Stinger',
                  fontSize: 23.w * 0.4,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: context.height * 0.10),
          CarouselSlider.builder(
            itemCount: compaines.length,
            itemBuilder: (context, index, realIndex) => Column(
              children: [
                Container(
                  height: context.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(compaines[index].logoAsset!),
                      fit: BoxFit.fitHeight,
                      isAntiAlias: true,
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.05),
                Text(
                  '${compaines[index].name}',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: 'Stinger',
                        fontSize: 20.w * 0.4,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
            options: CarouselOptions(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              height: context.height * 0.5,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  Widget fourthSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: fourthHeight,
              width: fourthWidth,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: fourthHeight == 50
                    ? () {
                        final exapndedHeight = context.height * 0.8;
                        const collapsedHeight = 50.0;

                        final expandedWidth = context.width * 0.8;
                        // const collapsedWidth = 150.0;

                        if (fourthHeight == collapsedHeight) {
                          setState(() {
                            fourthHeight = exapndedHeight;
                            fourthWidth = expandedWidth;
                          });
                        }
                      }
                    : null,
                child: fourthHeight == 50
                    ? Text(
                        thanksMessage ?? 'Contact Me',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontFamily: 'Stinger',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                    : Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: context.height * 0.02),
                            Text(
                              'Contact Me',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontFamily: 'Stinger',
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(hint: 'Name', controller: nameC),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(
                              hint: 'Email',
                              controller: emailC,
                              isEmail: true,
                            ),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(hint: 'Phone', controller: phoneC),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(
                                hint: 'Message', controller: messageC),
                            // SizedBox(height: context.height * 0.02),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                try {
                                  log('name: ${nameC.text}');
                                  log('email: ${emailC.text}');
                                  log('phone: ${phoneC.text}');
                                  log('message: ${messageC.text}');

                                  final module = ContactModule(
                                    name: nameC.text,
                                    email: emailC.text,
                                    phone: phoneC.text,
                                    message: messageC.text,
                                  );
                                  await FirebaseFirestore.instance
                                      .collection('contact')
                                      .add(module.toMap());

                                  setState(() {
                                    thanksMessage = 'Thanks.';
                                    nameC.clear();
                                    emailC.clear();
                                    phoneC.clear();
                                    messageC.clear();
                                    fourthHeight = 50;
                                    fourthWidth = 150;
                                  });
                                } catch (e) {
                                  log(e.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      padding: const EdgeInsets.all(12.0),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: const Text(
                                        'There\'s unexcpected error please try again later',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Send",
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context) => Positioned(
        right: 0,
        bottom: 0,
        child: Stack(
          children: [
            Image.asset(
              Assets.kar1mmohamed,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
              height: context.height * 0.8,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.01, sigmaY: 1),
                  child: Container(
                    // the size where the blurring starts
                    height: context.height * 0.4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class SmallScreen extends StatefulWidget {
  const SmallScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<SmallScreen> createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  double fourthHeight = 50;
  double fourthWidth = 150;
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final messageC = TextEditingController();

  String? thanksMessage;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            firstSection(context),
            secondSection(context),
            thirdSection(context),
            fourthSection(context),
          ],
        ),
      ),
    );
  }

  Widget firstSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[0],
      height: context.height,
      width: context.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          image(context),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: context.height * 0.2),
              child: Text(
                '   Karim \nMohamed',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'Stinger',
                      fontSize: 50.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget secondSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[1],
      height: context.height,
      width: context.width,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Your partner to implement your ideas.',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontFamily: 'Stinger',
                  fontSize: 50.w * 0.4,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  Widget thirdSection(BuildContext context) {
    return SizedBox(
      key: sectionsKeys[2],
      height: context.height,
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.height * 0.01),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'My clients are my partners.\n\nI work with them to achieve\n\nresults they can measure.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontFamily: 'Stinger',
                    fontSize: 25.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: context.height * 0.10),
          CarouselSlider.builder(
            itemCount: compaines.length,
            itemBuilder: (context, index, realIndex) => Column(
              children: [
                Container(
                  height: context.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(compaines[index].logoAsset!),
                      fit: BoxFit.fitHeight,
                      isAntiAlias: true,
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.05),
                Text(
                  '${compaines[index].name}',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: 'Stinger',
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
            options: CarouselOptions(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              height: context.height * 0.5,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  Widget fourthSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: fourthHeight,
              width: fourthWidth,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: fourthHeight == 50
                    ? () {
                        final exapndedHeight = context.height * 0.8;
                        const collapsedHeight = 50.0;

                        final expandedWidth = context.width * 0.8;
                        // const collapsedWidth = 150.0;

                        if (fourthHeight == collapsedHeight) {
                          setState(() {
                            fourthHeight = exapndedHeight;
                            fourthWidth = expandedWidth;
                          });
                        }
                      }
                    : null,
                child: fourthHeight == 50
                    ? Text(
                        thanksMessage ?? 'Contact Me',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontFamily: 'Stinger',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                    : Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: context.height * 0.02),
                            Text(
                              'Contact Me',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontFamily: 'Stinger',
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(hint: 'Name', controller: nameC),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(
                              hint: 'Email',
                              controller: emailC,
                              isEmail: true,
                            ),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(hint: 'Phone', controller: phoneC),
                            // SizedBox(height: context.height * 0.02),
                            textFormField(
                                hint: 'Message', controller: messageC),
                            // SizedBox(height: context.height * 0.02),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                try {
                                  log('name: ${nameC.text}');
                                  log('email: ${emailC.text}');
                                  log('phone: ${phoneC.text}');
                                  log('message: ${messageC.text}');

                                  final module = ContactModule(
                                    name: nameC.text,
                                    email: emailC.text,
                                    phone: phoneC.text,
                                    message: messageC.text,
                                  );
                                  await FirebaseFirestore.instance
                                      .collection('contact')
                                      .add(module.toMap());

                                  setState(() {
                                    thanksMessage = 'Thanks.';
                                    nameC.clear();
                                    emailC.clear();
                                    phoneC.clear();
                                    messageC.clear();
                                    fourthHeight = 50;
                                    fourthWidth = 150;
                                  });
                                } catch (e) {
                                  log(e.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      padding: const EdgeInsets.all(12.0),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: const Text(
                                        'There\'s unexcpected error please try again later',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Send",
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context) => Positioned(
        right: 0,
        bottom: 0,
        child: Stack(
          children: [
            Image.asset(
              Assets.kar1mmohamed,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
              height: context.height * 0.5,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.01, sigmaY: 1),
                  child: Container(
                    // the size where the blurring starts
                    height: context.height * 0.4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
