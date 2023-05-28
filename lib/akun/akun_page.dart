// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyek3/akun/edit_akun.dart';
import 'package:proyek3/akun/edit_password.dart';
import 'package:proyek3/auth/login_page.dart';
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
  late String id,role,nama;
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
        backgroundColor: Colors.black.withRed(120),
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
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
      ),
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
          : FutureBuilder<List<Warga>>(
              future: _apiService.getAkun(id,role),
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
                if(role == 'warga'){
                   pref.setString('id_warga', snapshot.data![0].id.toString());
                }
                return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: const [
                                Color.fromARGB(255, 119, 1, 1),
                                Color.fromARGB(255, 197, 49, 38)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
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
                              Center(
                                child: role == 'warga' ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: 
                                      NetworkImage(snapshot.data![0].photo),
                                ): CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  child: Icon(Icons.person,color: Colors.black.withRed(100),size: 80,),
                                )
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  role == 'warga' ? snapshot.data![0].nama_lengkap : nama,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                  color: Colors.black.withRed(100),
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
                                  backgroundColor: Colors.black.withRed(150),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                              child: Text('Edit Akun',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
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
                                backgroundColor: Colors.black.withRed(150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            child: Text('Edit Password',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
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
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17))),
                            child: Text('Logout',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                );
              },
            ),
    );
  }
}
