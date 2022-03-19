import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double defaultMargin = 24.0;
double defaultRadius = 17.0;

Color kPrimaryColor = Color(0xff5C40CC);
Color kBlackColor = Color(0xff1F1449);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGreyColor = Color(0xff9698A9);
Color kGreenColor = Color(0xff0EC3AE);
Color kRedColor = Color(0xffEB70A5);
Color kBackgroundColor = Color(0xffFAFAFA);
Color kInactiveColor = Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailableColor = Color(0xffE0D9FF);
Color kUnavailableColor = Color(0xffEBECF1);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);
TextStyle judulBukuConfirm = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);
TextStyle subBukuConfirm = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: Colors.black.withOpacity(0.60),
);
TextStyle methodConfirm = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: Colors.black.withOpacity(0.75),
);
