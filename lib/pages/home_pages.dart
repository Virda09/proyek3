// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_id/util/activity_card.dart';
import 'package:login_id/util/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          // app barr
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
 children: [

                 // name
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                       Text(
                         'Hello,',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       fontSize: 18,
                       ),
                       ), 
                       SizedBox(height: 8),
                       Text(
                         'Virda Aulia',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       fontSize: 24,
                       ),
                       ),
                   ],
                 ),
                 
                  // profile picture
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.person),
                    ),
                  ],
                 ),
                ),

          SizedBox(height: 25),

          // card -> how do you fell?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.red[900],
              borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                // animation or cute picture
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red[100],
                  //iconImagePath: 'assets/icons/hijab.png',
                ),
                SizedBox(
                  width: 20,
                ),

                // how do you feel + get started button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat Datang Di Aplikasi Perumahan Gajah Asri Jatibarang Baru-Indramayu. Perumahan aman nyaman dan tentram hanya diperumahan Gajah Asri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      ),
                      SizedBox(height: 12 ),

                      Text('Selamat Bergabung',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Get Started',
                          style: TextStyle(color: Colors.red[900]),
                          ),
                        )
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),

          SizedBox(height: 25),

          // search bar
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(12),
  ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'How can we help you?',
              ),
            )
          ),
          ),

          SizedBox(height: 25),
          // horizontal listview -> categories: dentiest, surgeon etc...
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryCard(
                  categoryName: 'Iuran',
                  iconImagePath: 'assets/icons/iuran.png',
                ),
                CategoryCard(
                  categoryName: 'Kegiatan',
                  iconImagePath: 'assets/icons/activity.png',
                   ),
                CategoryCard(
                  categoryName: 'Penjualan',
                  iconImagePath: 'assets/icons/home.png',
                ),
                CategoryCard(
                  categoryName: 'Aspirasi',
                  iconImagePath: 'assets/icons/aspirating.png',
                ),
                
              ],
            ),
          ),

          SizedBox(height: 25),

          // doctor list
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity List',
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
              ),
              ),
              Text('See all',
              style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
              ),
),
            ],
            ),
          ),

          SizedBox(height: 25),

          Expanded(
            child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ActivityCard(
                activityImagePath: 'assets/images/bola.jpg',
                activityName: 'Turnament',
                Keterangan: 'Warga melakukan kegiatan turnament untuk mempererat tali silaturrahmi' ,),
                ActivityCard(
                activityImagePath: 'assets/images/clean.jpg',
                activityName: 'Jumat Bersih',
                Keterangan: 'Warga melakukan bersih-bersih masjid di komplek' ,),
                ActivityCard(
                activityImagePath: 'assets/images/clean2.jpeg',
                activityName: 'Gotong Royong',
                Keterangan: 'Warga membersihkan lingkungan sekitar guna melestarikan kebersihan lingkungan' ,), 
            ],
          ))
        ],
    ),
  ),
);
}
}