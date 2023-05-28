// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final IconData icon;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text, required this.icon}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20,top: 45
              + 20, right: 20,bottom: 20
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              const SizedBox(height: 15,),
              Text(widget.descriptions,style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              const SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.text,style: const TextStyle(fontSize: 18),)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: Icon(widget.icon),
            ),
        ),
      ],
    );
  }
}