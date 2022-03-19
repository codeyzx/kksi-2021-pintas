import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintas_app/cubit/auth_cubit.dart';
import 'package:pintas_app/cubit/page_cubit.dart';
import 'package:pintas_app/shared/theme.dart';
import 'package:pintas_app/ui/onboard/login_screen.dart';
import 'help_page_view.dart';
import 'editProfilePage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context2) => ScreenUtilInit(
        designSize: Size(411, 731),
        builder: () => MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  color: Colors.black.withOpacity(0.87),
                  fontWeight: FontWeight.w500,
                ),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 26.w, right: 26.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                    if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kRedColor,
                          content: Text(state.error),
                        ),
                      );
                    } else if (state is AuthInitial) {
                      context.read<PageCubit>().setPage(0);
                      Navigator.pushReplacement(context2,
                          MaterialPageRoute(builder: (context) {
                        print('KEBACA COKKKKKKKKKKKKKKKKKK');
                        return LoginScreen();
                      }));
                    }
                  }, builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthSuccess) {
                      void signOut() {
                        context.read<AuthCubit>().signOut();
                      }

                      return Container(
                        width: 351.w,
                        height: 99.h,
                        margin: EdgeInsets.only(top: 30.h),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: HexColor("#39A2DB"))),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60.w,
                                      height: 60.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 17.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 149.w,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${state.user.name}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 22.sp,
                                                  color: Colors.black
                                                      .withOpacity(0.87),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 149.w,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${state.user.email}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13.sp,
                                                  color: Colors.black
                                                      .withOpacity(0.87),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 93.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FF3334"),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        signOut();
                                      },
                                      child: Text(
                                        "Sign Out",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                  SizedBox(height: 20.h),
                  Text(
                    "Account",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.black.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 10.h),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfilePage();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditProfilePage();
                                      }));
                                    },
                                    icon: Icon(
                                      Icons.person,
                                      size: 30.sp,
                                      color: HexColor("#39A2DB"),
                                    ),
                                  ),
                                  Text(
                                    "Edit Profile",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditProfilePage();
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#39A2DB"),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HelpPage();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HelpPage();
                                      }));
                                    },
                                    icon: Icon(
                                      Icons.help,
                                      size: 30.sp,
                                      color: HexColor("#39A2DB"),
                                    ),
                                  ),
                                  Text(
                                    "Help",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HelpPage();
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#39A2DB"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "General",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.black.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 10.h),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final url =
                                'https://www.termsfeed.com/live/a21752d0-e8c4-430a-ab33-103ea3922795';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                                forceSafariVC: true,
                                enableJavaScript: true,
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final url =
                                          'https://www.termsfeed.com/live/a21752d0-e8c4-430a-ab33-103ea3922795';
                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                          forceWebView: true,
                                          forceSafariVC: true,
                                          enableJavaScript: true,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.library_books_rounded,
                                      size: 30.sp,
                                      color: HexColor("#39A2DB"),
                                    ),
                                  ),
                                  Text(
                                    "Terms & Condition",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final url =
                                        'https://www.termsfeed.com/live/a21752d0-e8c4-430a-ab33-103ea3922795';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceWebView: true,
                                        forceSafariVC: true,
                                        enableJavaScript: true,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#39A2DB"),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final url =
                                'https://www.privacypolicygenerator.info/live.php?token=NYOzJKcXMWHWOY5AfYGX4ytGmVknZis5';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceWebView: true,
                                forceSafariVC: true,
                                enableJavaScript: true,
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final url =
                                          'https://www.privacypolicygenerator.info/live.php?token=NYOzJKcXMWHWOY5AfYGX4ytGmVknZis5';
                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                          forceWebView: true,
                                          forceSafariVC: true,
                                          enableJavaScript: true,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.privacy_tip_rounded,
                                      size: 30.sp,
                                      color: HexColor("#39A2DB"),
                                    ),
                                  ),
                                  Text(
                                    "Privacy & Policy",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.black.withOpacity(0.87),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final url =
                                        'https://www.privacypolicygenerator.info/live.php?token=NYOzJKcXMWHWOY5AfYGX4ytGmVknZis5';
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceWebView: true,
                                        forceSafariVC: true,
                                        enableJavaScript: true,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: HexColor("#39A2DB"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
