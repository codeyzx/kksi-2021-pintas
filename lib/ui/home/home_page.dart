import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pintas_app/cubit/auth_cubit.dart';
import 'package:pintas_app/ui/book/book_type_page.dart';
import 'package:pintas_app/models/menu_book.dart';
import 'package:pintas_app/models/news_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pintas_app/models/popular_book_card.dart';
import 'package:pintas_app/ui/book/categories_details.dart';
import 'package:pintas_app/ui/book/book_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imageList = imagesItem;
  final categoriesImage = categoriesItem;

  @override
  Widget build(BuildContext context) {
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    final Query ascCategories =
        categories.limit(4).orderBy('id', descending: false);
    final Query descCategories =
        categories.limit(3).orderBy('id', descending: true);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference noticeCollection = firestore.collection('buku');
    final Query isPopular =
        noticeCollection.where("isPopular", isEqualTo: true);
    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor('#39A2DB'),
          body: SafeArea(
            child: ListView(children: [
              Column(
                children: [
                  header(),
                  Container(
                    margin: EdgeInsets.only(top: 30.h),
                    width: 1.sw,
                    height: 1030.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 3.w,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, left: 30.w, right: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "News & Information",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 145.h,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 8),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 900),
                              enlargeCenterPage: true,
                            ),
                            items: imageList
                                .map((e) => ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Image.network(
                                            e,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                70.0,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 107,
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, left: 30.w, right: 40.w, bottom: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Categories",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: ascCategories.snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 30.w,
                                              right: 30.w,
                                              bottom: 20.h),
                                          width: 374.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: (snapshot.data!)
                                                    .docs
                                                    .map((e) {
                                                  return Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 70.w,
                                                      height: 110.h,
                                                      margin: EdgeInsets.only(
                                                          right: 10.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return CategoriesDetails(
                                                                    nama: e[
                                                                        'nama'],
                                                                    isKonvensional:
                                                                        e['isKonvensional']);
                                                              }));
                                                            },
                                                            icon: Image.network(
                                                                e['icon']),
                                                            iconSize: 50.sp,
                                                          ),
                                                          Text(
                                                            e['nama'],
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                            StreamBuilder<QuerySnapshot>(
                                stream: descCategories.snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 30.w,
                                              right: 30.w,
                                              bottom: 20.h),
                                          width: 374.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 5.h,
                                                  left: 10.w,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: (snapshot.data!)
                                                      .docs
                                                      .map((e) {
                                                    return Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 70.w,
                                                        height: 110.h,
                                                        margin: EdgeInsets.only(
                                                            right: 10.w),
                                                        child: Column(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return CategoriesDetails(
                                                                      nama: e[
                                                                          'nama'],
                                                                      isKonvensional:
                                                                          e['isKonvensional']);
                                                                }));
                                                              },
                                                              icon: Image
                                                                  .network(e[
                                                                      'icon']),
                                                              iconSize: 50.sp,
                                                            ),
                                                            Text(e['nama']),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: 15.h,
                                                  right: 25.w,
                                                  left: 5.w,
                                                ),
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return BookTypePage();
                                                        }));
                                                      },
                                                      icon: Image.network(
                                                          'https://cdn-icons-png.flaticon.com/512/512/512142.png'),
                                                      iconSize: 40.sp,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 5.h,
                                                      ),
                                                      child: Text("More"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, left: 30.w, right: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular Books",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: isPopular.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: (snapshot.data!)
                                    .docs
                                    .map(
                                      (e) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookPage(
                                                          e.id,
                                                          e['image'],
                                                          e['judul'],
                                                          e['jumlahHalaman'],
                                                          e['stok'],
                                                          e['isKonvensional'],
                                                          e['penulis'],
                                                          e['sinopsis'],
                                                          e['ebook'],
                                                        )));
                                          },
                                          child: PopularBookCard(
                                            menu: Menu(
                                                id: e.id,
                                                isPopular: e['isPopular'],
                                                isKonvensional:
                                                    e['isKonvensional'],
                                                stok: e['stok'],
                                                jumlahHalaman:
                                                    e['jumlahHalaman'],
                                                tahunTerbit: e['tahunTerbit'],
                                                categories: e['categories'],
                                                image: e['image'],
                                                judul: e['judul'],
                                                penulis: e['penulis'],
                                                penerbit: e['penerbit'],
                                                sinopsis: e['sinopsis']),
                                          )),
                                    )
                                    .toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget header() {
  return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
    if (state is AuthSuccess) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 45.h),
            height: 100.h,
            width: 374.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 70,
                    height: 70,
                    child: Image.network(
                      'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.w,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Hello ${state.user.name},",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Welcome Back!",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  });
}
