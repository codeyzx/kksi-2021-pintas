// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pintas_app/ui/onboard/login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: PageView(
              pageSnapping: true,
              controller: pageController,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 41.w, right: 39.w, top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageController.jumpToPage(2);
                          },
                          child: Text(
                            "Skip",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          )),
                      SizedBox(
                        height: 63.h,
                      ),
                      Center(
                        child: Container(
                          width: 251.w,
                          height: 224.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/cyborg-book.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Center(
                        child: Text(
                          "Find your book",
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                        child: Text(
                          "Dari Konvensional ke kontemporer, kamu akan menemukan semuanya disini",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 66.h),
                      Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 15.w, left: 130.w),
                            decoration: BoxDecoration(
                              color: HexColor("#39A2DB"),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: HexColor('#C4C4C4'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 56.w),
                            decoration: BoxDecoration(
                              color: HexColor('#C4C4C4'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                              child: Text(
                                "Next",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#39A2DB"),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 46.w, right: 34.w, top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                pageController.jumpToPage(2);
                              },
                              child: Text(
                                "Skip",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 66.h,
                      ),
                      Center(
                        child: Container(
                          width: 275.w,
                          height: 216.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/girl-read.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Center(
                        child: Text(
                          "Make sure it's available",
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Text(
                          "Tanpa perlu khawatir buku tidak tersedia, kamu dapat melihat stok buku tersebut",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 66.h),
                      Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 15.w, left: 130.w),
                            decoration: BoxDecoration(
                              color: HexColor('#C4C4C4'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: HexColor('#39A2DB'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 56.w),
                            decoration: BoxDecoration(
                              color: HexColor('#C4C4C4'),
                              shape: BoxShape.circle,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                              child: Text(
                                "Next",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#39A2DB"),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 66.h,
                      ),
                      Center(
                        child: Container(
                          width: 321.w,
                          height: 218.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/read-lamp.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Center(
                        child: Text(
                          "Avoid Queues",
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Center(
                        child: Text(
                          "Menghindari antrian panjang serta berdiri di depan perpustakaan",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 90.h),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return LoginScreen();
                                    }));
                          },
                          child: Container(
                            width: 300.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: HexColor("#39A2DB"),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
