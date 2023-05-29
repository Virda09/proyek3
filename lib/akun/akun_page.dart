// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek3/akun/edit_akun.dart';
import 'package:proyek3/akun/edit_password.dart';
import 'package:proyek3/auth/login_page.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/warga.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  late SharedPreferences pref;
  final ApiService _apiService = ApiService();
  List<Warga> data = [];
  late Warga warga;
  late String id, role, nama;
  bool _isLoading = true;

  _getAkun() async {
    pref = await SharedPreferences.getInstance();
    id = pref.getString('id')!;
    role = pref.getString('role')!;
    nama = pref.getString('nama')!;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getAkun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun"),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            },
            child: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            )),
        automaticallyImplyLeading: false,
      ),
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
          : FutureBuilder<List<Warga>>(
              future: _apiService.getAkun(id, role),
              builder: (context, AsyncSnapshot<List<Warga>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.wifi_off),
                          SizedBox(
                            height: 20,
                          ),
                          Text("No Connection"),
                        ],
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
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
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.wifi_off),
                      SizedBox(
                        height: 20,
                      ),
                      Text("No Connection"),
                    ],
                  ));
                }
                if (role == 'warga') {
                  pref.setString('id_warga', snapshot.data![0].id.toString());
                }
                return Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage('assets/bg2.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 25,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: role == 'warga'
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                            snapshot.data![0].photo),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: secondaryColor,
                                        radius: 60,
                                        child: Icon(
                                          Icons.person,
                                          color: primaryColor,
                                          size: 80,
                                        ),
                                      )),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                role == 'warga'
                                    ? snapshot.data![0].nama_lengkap
                                    : nama,
                                style: TextStyle(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (role == 'warga')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditAkunPage(
                                        id: id,
                                        nama: snapshot.data![0].nama_lengkap,
                                        tempat: snapshot.data![0].tempat_lahir,
                                        tanggal:
                                            snapshot.data![0].tanggal_lahir,
                                        jk: snapshot.data![0].jenis_kelamin,
                                        alamat: snapshot.data![0].alamat,
                                        agama: snapshot.data![0].agama,
                                        status: snapshot.data![0].status,
                                        pekerjaan: snapshot.data![0].pekerjaan,
                                        photo: snapshot.data![0].photo,
                                        telepon: snapshot.data![0].telepon),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                              child: Text('Edit Akun',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor)),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPasswordPage(id: id),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            child: Text('Edit Password',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            child: Text('Logout',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

