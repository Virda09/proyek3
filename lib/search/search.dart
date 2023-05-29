import 'package:flutter/material.dart';
import 'package:proyek3/search/custome_search.dart';

class GFG extends StatefulWidget {
  const GFG({Key? key}) : super(key: key);
 
  @override
  State<GFG> createState() => _GFGState();
}
 
class _GFGState extends State<GFG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GeeksForGeeks",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}