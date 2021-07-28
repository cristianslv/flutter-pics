import 'package:flutter/material.dart';

class Loader {
  static Widget build() {
    return
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "icon.png",
              width: 150,
              height: 150
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 225,
              height: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF30C5EA)),
                  backgroundColor: Color(0xFFFFE681),
                ),
              ),
            )
            // CircularProgressIndicator()
          ],
        ),
      );
  }
}