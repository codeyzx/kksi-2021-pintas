import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintas_app/models/user_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to Pick Image: $e');
    }
  }

  Future uploadImage() async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(image!.path)}');

    final results = await ref.putFile(File(image!.path));
    final imageUrl = await results.ref.getDownloadURL();

    print('Link Download : $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: HexColor("#39A2DB"),
                )),
            title: Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Stack(
                        children: [
                          ClipOval(
                            child: (image != null)
                                ? Material(
                              color: Colors.transparent,
                              child: Ink.image(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                                width: 128.w,
                                height: 128.h,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                            )
                                : Material(
                              color: Colors.transparent,
                              child: Ink.image(
                                image: NetworkImage(
                                  'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                                ),
                                fit: BoxFit.cover,
                                width: 128.w,
                                height: 128.h,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    color: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        color: Colors.blue,
                                        child: IconButton(
                                            onPressed: () {
                                              pickImage();
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  )))
                        ],
                      )),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NIS",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: TextField(
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "2021xxxxxx",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: HexColor("#55585F"),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#39A2DB"), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Nama",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: TextField(
                              obscureText: false,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "User",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: HexColor("#55585F"),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#39A2DB"), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "user@gmail.com",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: HexColor("#55585F"),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#39A2DB"), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Nomor Handphone",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: TextField(
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "08211777777",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: HexColor("#55585F"),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#39A2DB"), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  uploadImage();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 167.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: HexColor("39A2DB"),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Simpan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}