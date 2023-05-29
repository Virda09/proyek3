import 'package:flutter/material.dart';
import 'package:proyek3/color.dart';
import 'package:proyek3/iuran/iuran_page.dart';
import 'package:proyek3/iuran/show_warga.dart';
import 'package:proyek3/model/warga.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWarga extends StatefulWidget {
  final List<Warga>? warga;
  const ListWarga({super.key, this.warga});

  @override
  State<ListWarga> createState() => _ListWargaState();
}

class _ListWargaState extends State<ListWarga> {
late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        image: const DecorationImage(
          opacity: 0.5,
          image: AssetImage('assets/bg2.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Warga data = widget.warga![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWarga(
                      warga: data,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              data.photo,
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 205,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data.nama_lengkap,
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
                                "Kontak : ${data.telepon}",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                "Alamat : ${data.alamat}",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                    ),
                                    onPressed: () async {
                                      pref = await SharedPreferences.getInstance();
                                      pref.setString(
                                          'id_warga', data.id.toString());
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const IuranPage(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.payment,
                                            color: secondaryColor),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Lihat Iuran",
                                          style:
                                              TextStyle(color: secondaryColor),
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
          itemCount: widget.warga!.length,
        ),
      ),
    );
  }
}
