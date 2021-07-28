import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pics/controllers/pics_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  final String pictureString;

  const AddPage({ this.pictureString, Key key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var decodedPicture;
  Image _image;
  PicsController picsController = PicsController();

  
  @override
  void initState() {
    super.initState();

    var decodedPicture = base64Decode(widget.pictureString);
    _image = Image.memory(decodedPicture);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Picked Picture",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: _image,
              margin: EdgeInsets.only(left: 15, right: 15),
              height: 300,
              padding: EdgeInsets.all(2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4)
                )
              ),
              controller: picsController.title,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4)
                )
              ),
              controller: picsController.description,
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_sharp),
        onPressed: () {
          picsController.inserir(widget.pictureString).then((value) {
            Navigator.pop(context);
          });

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}