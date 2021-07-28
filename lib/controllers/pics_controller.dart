import 'package:flutter/cupertino.dart';
import 'package:flutter_pics/repositories/pics_repository.dart';
import 'package:flutter_pics/models/pic.dart';
import 'package:location/location.dart';
import 'dart:async';

class PicsController {
  List<Pic> pics = [];
  PicsRepository picsRepository = PicsRepository();

  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();
  String long;
  String lat;
  int date;

  Future<void> inserir(String picStr) async{
    LocationData location = await Location.instance.getLocation();

    Pic pic = Pic(picStr: picStr, title: title.text, description: description.text, lat: (location.latitude).toString(), long: (location.longitude).toString(), date: DateTime.now().millisecondsSinceEpoch);

    description.clear();
    title.clear();

    return await picsRepository.insert(pic);
  }

  Future<void> select() async{
    return picsRepository.selectAll().then((value) {
      pics = value;
    });
  }

  Future<void> remove(int i) async {
    Pic pic = pics[i];

    return await picsRepository.delete(pic);
  }
}