// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/home/home_page.dart';
import 'package:proyek3/iuran/list_warga.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/warga.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Warga>? data;

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
        backgroundColor: primaryColor,
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
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ListWargaDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
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
              : FutureBuilder(
                  future: _apiService.getAkun(id, role),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Warga>> snapshot) {
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
                        List<Warga>? warga = snapshot.data;
                        data = snapshot.data;
                        return ListWarga(warga: warga);
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}

class ListWargaDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: theme.primaryIconTheme.copyWith(color: secondaryColor),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Warga> warga = [];
    for (var dt in data!) {
      if (dt.nama_lengkap.toLowerCase().contains(query.toLowerCase())) {
        warga.add(dt);
      }
    }
    return ListWarga(warga: warga);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Warga> warga = [];
    for (var dt in data!) {
      if (dt.nama_lengkap.toLowerCase().contains(query.toLowerCase())) {
        warga.add(dt);
      }
    }
    return ListWarga(warga: warga);
  }
}
