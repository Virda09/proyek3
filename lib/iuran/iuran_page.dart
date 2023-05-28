// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/iuran/add_edit_page.dart';
import 'package:proyek3/iuran/show_page.dart';
import 'package:proyek3/iuran/warga_page.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/iuran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IuranPage extends StatefulWidget {
  const IuranPage({super.key});

  @override
  State<IuranPage> createState() => _IuranPageState();
}

class _IuranPageState extends State<IuranPage> {
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
    if(role == 'warga'){
      id_warga = id;
    }else{
      id_warga = pref.getString('id_warga')!;
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
        title: const Text("Iuran"),
        backgroundColor: Colors.black.withRed(120),
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => role == 'warga'
                          ? const HomePage()
                          : const WargaPage()),
                  (route) => false);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
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
                future: _apiService.getIuran(id_warga),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Iuran>> snapshot) {
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
                      List<Iuran>? iuran = snapshot.data;
                      return _buildListView(iuran!);
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

  Widget _buildListView(List<Iuran> iuran) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Iuran data = iuran[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowPage(
                    id_warga: id_warga,
                    iuran: data,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tanggal : ${_apiService.dateFormat((data.created_at ?? ""))}",
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
                        "Nominal : ${data.nominal}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Text(
                            "Status : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            data.status,
                            style: data.status == "Diterima"
                                ? const TextStyle(color: Colors.green)
                                : data.status == "Ditolak"
                                    ? const TextStyle(color: Colors.red)
                                    : const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (data.status != "Diterima")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Warning"),
                                        content: const Text(
                                            "Anda yakin ingin menghapus iuran ini"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.black.withRed(100),
                                            ),
                                            child: const Text(
                                              "Ya",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _apiService
                                                  .deleteIuran(
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
                                              backgroundColor:
                                                  Colors.black.withRed(100),
                                            ),
                                            child: const Text(
                                              "Tidak",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                children: const [
                                  Icon(
                                    Icons.highlight_remove,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Hapus",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditPage(
                                      id_warga: id_warga,
                                      iuran: data,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: iuran.length,
      ),
    );
  }
}
