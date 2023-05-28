// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek3/akun/akun_page.dart';
import 'package:proyek3/aspirasi/aspirasi_page.dart';
import 'package:proyek3/home/show_page.dart';
import 'package:proyek3/iuran/iuran_page.dart';
import 'package:proyek3/home/build_menuicon.dart';
import 'package:proyek3/iuran/warga_page.dart';
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
      backgroundColor: Colors.white,
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
                color: Colors.black.withRed(100),
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
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
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
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 25,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next workout",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Legs Toning",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "and Glutes Workout",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          SizedBox(height: 25),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "60 min",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 60,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 40,
                          offset: Offset(1, 5),
                          color: Colors.black26,
                        ),
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(-1, -5),
                          color: Colors.black26,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuIcon(
                            title: "Aspirasi",
                            icon: Icons.speaker_notes,
                            aksi: AspirasiPage(),
                          ),
                          MenuIcon(
                            title: "iuran",
                            icon: Icons.payment,
                            aksi: role == 'warga' ? IuranPage() : WargaPage(),
                          ),
                          MenuIcon(
                            title: "Akun",
                            icon: Icons.person,
                            aksi: AkunPage(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Berita & Kegiatan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
                                children: const [
                                  Icon(
                                    Icons.speaker_notes,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 5),
                                  Text("Tidak Ada Berita atau Kegiatan",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
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
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 119, 1, 1),
                  Color.fromARGB(255, 197, 49, 38)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(4, 5),
                  color: Colors.black45,
                ),
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(-1, -5),
                  color: Colors.black45,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.newspaper, color: Colors.white, size: 40),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.nama,
                          style: const TextStyle(
                              color: Colors.white,
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
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            const Text(
                              "Deskripsi : ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data.deskripsi,
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: kegiatan.length,
    );
  }
}
