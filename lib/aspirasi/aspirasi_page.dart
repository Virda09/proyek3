// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/aspirasi/add_edit_page.dart';
import 'package:proyek3/aspirasi/show_page.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/aspirasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AspirasiPage extends StatefulWidget {
  const AspirasiPage({super.key});

  @override
  State<AspirasiPage> createState() => _AspirasiPageState();
}

class _AspirasiPageState extends State<AspirasiPage> {
  @override
  late BuildContext context;
  late ApiService _apiService;
  late SharedPreferences pref;
  late String id, id_warga, role;
  bool _isLoading = true;

  _getAkun() async {
    pref = await SharedPreferences.getInstance();
    id = pref.getString('id')!;
    role = pref.getString('role')!;
    if (role == 'warga') {
      id_warga = id;
    }
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
        title: const Text("List Aspirasi"),
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
                      future: _apiService.getAspirasi(id, role),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Aspirasi>> snapshot) {
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
                            List<Aspirasi>? aspirasi = snapshot.data;
                            return _buildListView(aspirasi!);
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    role == 'warga'
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
                                            builder: (context) => AddEditPage(
                                              id_warga: id_warga,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(17))),
                                      child: Text('Buat Aspirasi',
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

  Widget _buildListView(List<Aspirasi> aspirasi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Aspirasi data = aspirasi[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowPage(
                    id_warga: id_warga,
                    aspirasi: data,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Nama : ${data.nama}",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: Container()),
                          Text(
                            _apiService.dateFormat((data.created_at ?? "")),
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Kategori : ${data.jenis_aspirasi}",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: TextStyle(color: primaryColor),
                              ),
                              Text(
                                data.status,
                                style: data.status == "Dibaca"
                                    ? const TextStyle(color: Colors.green)
                                    : const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        data.aspirasi,
                        style: TextStyle(color: primaryColor, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      if (data.status != "Dibaca" && role == 'warga')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                            "Anda yakin ingin menghapus Aspirasi dengan inisial : ${data.nama}"),
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
                                                  .deleteAspirasi(
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
                                      id_warga: id_warga,
                                      aspirasi: data,
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
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: aspirasi.length,
      ),
    );
  }
}
