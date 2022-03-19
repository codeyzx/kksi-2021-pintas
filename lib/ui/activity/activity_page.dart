import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintas_app/cubit/auth_cubit.dart';
import 'package:pintas_app/models/activity_card.dart';
import 'package:pintas_app/models/menu_activity.dart';
import 'package:pintas_app/models/transaction_model.dart';
import 'package:pintas_app/ui/activity/return_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference transactionCollection =
        firestore.collection('history');

    return ScreenUtilInit(
      designSize: Size(411, 731),
      builder: () => MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Activity",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "Sedang Dibaca"),
                  Tab(text: "Riwayat"),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  final Query transactions = transactionCollection
                      .where("userID", isEqualTo: state.user.nis);
                  final Query dibaca =
                      transactions.where("status_buku", isEqualTo: false);
                  final Query dikembalikan =
                      transactions.where("status_buku", isEqualTo: true);
                  return TabBarView(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: dibaca.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              //* Sedang Dibaca
                              return Container(
                                color: Colors.white12,
                                child: ListView(
                                  children: (snapshot.data!)
                                      .docs
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              TransactionModel transaction =
                                                  TransactionModel(
                                                userID: e['userID'],
                                                denda: e['denda'],
                                                method: e['method'] ==
                                                        "Bawa Pulang"
                                                    ? TransactionMethod
                                                        .bawa_pulang
                                                    : TransactionMethod
                                                        .baca_di_perpustakaan,
                                                startTime: DateTime
                                                    .fromMillisecondsSinceEpoch(e[
                                                            'startTime']
                                                        .millisecondsSinceEpoch),
                                                endTime: DateTime
                                                    .fromMillisecondsSinceEpoch(e[
                                                            'endTime']
                                                        .millisecondsSinceEpoch),
                                                bookID: e['bookID'],
                                                judul: e['judul'],
                                                jumlahHalaman:
                                                    e['jumlahHalaman'],
                                                image: e['image'],
                                                penulis: e['penulis'],
                                              );
                                              Navigator.push(
                                                this.context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReturnPage(
                                                    idTransaction: e.id,
                                                    transaction: transaction,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ActivityCard(
                                                menu: MenuActivity(
                                                    jumlahHalaman:
                                                        e['jumlahHalaman'],
                                                    image: e['image'],
                                                    judul: e['judul'],
                                                    penulis: e['penulis'])),
                                          ))
                                      .toList(),
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                      StreamBuilder<QuerySnapshot>(
                          stream: dikembalikan.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              //* Riwayat
                              return Container(
                                color: Colors.white12,
                                child: ListView(
                                  children: (snapshot.data!)
                                      .docs
                                      .map((e) => ActivityCard(
                                          menu: MenuActivity(
                                              jumlahHalaman: e['jumlahHalaman'],
                                              image: e['image'],
                                              judul: e['judul'],
                                              penulis: e['penulis'])))
                                      .toList(),
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
