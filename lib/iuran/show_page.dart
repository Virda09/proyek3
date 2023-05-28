// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches, non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:proyek3/model/api_service.dart';
import 'package:proyek3/model/iuran.dart';

class ShowPage extends StatefulWidget {
  final String id_warga;
  final Iuran? iuran;

  const ShowPage({super.key, required this.id_warga, this.iuran});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  TextEditingController nominal = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  String bukti = "";
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    if (widget.iuran != null) {
      nominal.text = widget.iuran!.nominal;
      bukti = widget.iuran!.bukti;
      tanggal.text = _apiService.dateFormat(widget.iuran!.created_at!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        elevation: 0,
        title: Text(
          'Data Iuran',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.black.withRed(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Detail Iuran",
                          style: TextStyle(
                            color: Colors.black.withRed(100),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                //to show image, you type like this.
                                widget.iuran!.bukti,
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              )),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      color: Colors.black.withRed(100)),
                                  controller: nominal,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black.withRed(100),
                                          width: 2,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black.withRed(100),
                                          width: 2,
                                        )),
                                    focusColor: Colors.black.withRed(100),
                                    hintText: "Nominal",
                                    labelText: "Nominal",
                                    labelStyle: TextStyle(
                                      color: Colors.black.withRed(100),
                                    ),
                                    prefixIcon: Icon(Icons.money,
                                        color: Colors.black.withRed(100)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      color: Colors.black.withRed(100)),
                                  controller: tanggal,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black.withRed(100),
                                          width: 2,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black.withRed(100),
                                          width: 2,
                                        )),
                                    focusColor: Colors.black.withRed(100),
                                    hintText: "Tanggal Bayar",
                                    labelText: "Tanggal Bayar",
                                    labelStyle: TextStyle(
                                      color: Colors.black.withRed(100),
                                    ),
                                    prefixIcon: Icon(Icons.date_range,
                                        color: Colors.black.withRed(100)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
