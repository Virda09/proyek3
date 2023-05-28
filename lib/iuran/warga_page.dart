// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/aspirasi/add_edit_page.dart';
import 'package:proyek3/aspirasi/show_page.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/iuran/iuran_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/warga.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WargaPage extends StatefulWidget {
  const WargaPage({super.key});

  @override
  State<WargaPage> createState() => _WargaPageState();
}

class _WargaPageState extends State<WargaPage> {
  @override
  late BuildContext context;
  late ApiService _apiService;
  late SharedPreferences pref;
  late String id, role;
  bool _isLoading = true;

  _getAkun() async {
    pref = await SharedPreferences.getInstance();
    id = pref.getString('id')!;
    role = pref.getString('role')!;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getAkun();
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Warga"),
        backgroundColor: Colors.black.withRed(120),
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: _isLoading
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
            : FutureBuilder(
                future: _apiService.getAkun(id, role),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Warga>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Something wrong with message: ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.speaker_notes,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text("Data Kosong",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20)),
                          ],
                        ),
                      );
                    } else {
                      List<Warga>? warga = snapshot.data;
                      return _buildListView(warga!);
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }

  Widget _buildListView(List<Warga> warga) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Warga data = warga[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowPage(
                    id_warga: data.id.toString(),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:5),
              child: Container(
                height: 150,
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
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: 
                              Image.network(
                                  //to show image, you type like this.
                                  data.photo,
                                  fit: BoxFit.fill,
                                  width: 120,
                                  height: 130,
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width-200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.nama_lengkap,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Kontak : ${data.telepon}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "Alamat : ${data.alamat}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    pref.setString(
                                        'id_warga', data.id.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const IuranPage(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.payment,
                                          color: Colors.black.withRed(150)),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Lihat Iuran",
                                        style: TextStyle(
                                            color: Colors.black.withRed(150)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: warga.length,
      ),
    );
  }
}
