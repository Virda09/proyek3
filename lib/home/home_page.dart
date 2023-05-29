// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek3/akun/akun_page.dart';
import 'package:proyek3/aspirasi/aspirasi_page.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/home/show_page.dart';
import 'package:proyek3/iuran/iuran_page.dart';
import 'package:proyek3/home/build_menuicon.dart';
import 'package:proyek3/iuran/warga_page.dart';
import 'package:proyek3/kegiatan/kegiatan_page.dart';
import 'package:proyek3/model/activity.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/kegiatan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences pref;
  late String id;
  late String role;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  _getAkun() async {
    pref = await SharedPreferences.getInstance();
    id = pref.getString('id')!;
    role = pref.getString('role')!;
    setState(
      () {
        _isLoading = false;
      },
    );
  }

  @override
  void initState() {
    _getAkun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Loading..."),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: primaryColor,
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('assets/bg2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: const EdgeInsets.only(
                top: 50,
                left: 30,
                right: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Selamat Datang, ",
                        style: TextStyle(
                          fontSize: 30,
                          color: secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${role[0].toUpperCase()}${role.substring(1).toLowerCase()}",
                        style: TextStyle(
                          fontSize: 30,
                          color: secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor, width: 4),
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(255, 119, 1, 1),
                            Color.fromARGB(255, 197, 49, 38)
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(80),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(5, 10),
                            blurRadius: 20,
                            color: Color.fromARGB(31, 105, 104, 104),
                          ),
                        ]),
                    child: FutureBuilder(
                      future: _apiService.getActivity(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Activity>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                "Something wrong with message: ${snapshot.error.toString()}"),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.data!.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 20,
                                top: 25,
                                right: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kegiatan Hari Ini :",
                                    style: TextStyle(
                                        fontSize: 16, color: secondaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Tidak Ada Kegiatan",
                                    style: TextStyle(
                                        fontSize: 25, color: secondaryColor),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            List<Activity>? dt = snapshot.data;
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 20,
                                top: 25,
                                right: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kegiatan Hari Ini :",
                                    style: TextStyle(
                                        fontSize: 16, color: secondaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    dt![0].nama,
                                    style: TextStyle(
                                        fontSize: 25, color: secondaryColor),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    dt[0].deskripsi,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20, color: secondaryColor),
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range,
                                            size: 20,
                                            color: secondaryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dt[0].tanggal_kegiatan,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: secondaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuIcon(
                          role: role,
                          title: "Aspirasi",
                          icon: Icons.speaker_notes,
                          aksi: AspirasiPage(),
                        ),
                        SizedBox(width: 14),
                        MenuIcon(
                          role: role,
                          title: "iuran",
                          icon: Icons.payment,
                          aksi: role == 'warga' ? IuranPage() : WargaPage(),
                        ),
                        if (role != 'warga') SizedBox(width: 14),
                        if (role != 'warga')
                          MenuIcon(
                            role: role,
                            title: "Kegiatan",
                            icon: Icons.local_activity,
                            aksi: KegiatanPage(),
                          ),
                        SizedBox(width: 14),
                        MenuIcon(
                          role: role,
                          title: "Akun",
                          icon: Icons.person,
                          aksi: AkunPage(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Berita & Kegiatan",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: secondaryColor),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KegiatanPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Detail",
                          style: TextStyle(color: secondaryColor, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: secondaryColor,
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _apiService.getKegiatan(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Kegiatan>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                "Something wrong with message: ${snapshot.error.toString()}"),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.speaker_notes,
                                    size: 60,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(height: 5),
                                  Text("Tidak Ada Berita atau Kegiatan",
                                      style: TextStyle(
                                          color: secondaryColor, fontSize: 20)),
                                ],
                              ),
                            );
                          } else {
                            List<Kegiatan>? kegiatan = snapshot.data;
                            return _buildListView(kegiatan!);
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildListView(List<Kegiatan> kegiatan) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        Kegiatan data = kegiatan[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowPage(
                  kegiatan: data,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryColor, width: 3)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:
                          Icon(Icons.newspaper, color: primaryColor, size: 40),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.nama,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _apiService.dateFormat((data.created_at ?? "")),
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                Text(
                                  "Deskripsi : ",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Text(
                                  data.deskripsi,
                                  style: TextStyle(color: primaryColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: kegiatan.length,
    );
  }
}
