// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/home/show_page.dart';
import 'package:proyek3/kegiatan/add_edit_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/kegiatan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KegiatanPage extends StatefulWidget {
  const KegiatanPage({super.key});

  @override
  State<KegiatanPage> createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
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
        title: const Text("List Kegiatan / Berita"),
        backgroundColor: Colors.black.withRed(120),
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            },
            child: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            )),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            image: const DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/bg2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
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
              : Stack(
                  children: [
                    FutureBuilder(
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
                                  const SizedBox(height: 5),
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
                    role == 'koordinator'
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SizedBox(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddEditPage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17))),
                                      child: Text('Buat Kegiatan / Berita',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Kegiatan> kegiatan) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
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
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor, width: 3)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.newspaper,
                            color: primaryColor, size: 40),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:20,horizontal:10),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data.nama,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
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
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(right:8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Warning"),
                                        content: Text(
                                            "Anda yakin ingin menghapus kegiatan/berita dengan judul : ${data.nama}"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                            ),
                                            child: Text(
                                              "Ya",
                                              style: TextStyle(
                                                  color: secondaryColor),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _apiService
                                                  .deleteKegiatan(
                                                      data.id.toString())
                                                  .then((isSuccess) {
                                                if (isSuccess) {
                                                  setState(() {});
                                                  ScaffoldMessenger.of(
                                                          this.context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Hapus data berhasil")));
                                                } else {
                                                  ScaffoldMessenger.of(
                                                          this.context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Hapus data gagal")));
                                                }
                                              });
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                            ),
                                            child: Text(
                                              "Tidak",
                                              style: TextStyle(
                                                  color: secondaryColor),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.highlight_remove,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Hapus",
                                    style: TextStyle(color: secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditPage(
                                      kegiatan: data,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: secondaryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Edit",
                                    style: TextStyle(color: secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
