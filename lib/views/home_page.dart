import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pics/components/loader.dart';
import 'package:flutter_pics/config/database.dart';
import 'package:flutter_pics/controllers/pics_controller.dart';
import 'package:flutter_pics/controllers/theme_controller.dart';
import 'package:flutter_pics/repositories/pics_repository.dart';
import 'package:flutter_pics/views/add_page.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  Image _image;

  bool _loading = true;
  PicsController picsController = PicsController();

  @override
  void initState() {
    super.initState();

    BancoDeDados db = BancoDeDados();

    db.openDb().then((value) {
      select();
    });
  }

  void select() {
    picsController.select().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = ThemeController(context: context);
    Brightness brightness = Theme.of(context).brightness;
    
    return Scaffold(
      appBar: showAppBar(themeController, brightness),
      body: 
        _loading ? 
        Loader.build():
        Padding(
          padding: EdgeInsets.all(15),
          child: picsController.pics.length > 0 ? Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var decodedPicture = base64Decode(picsController.pics[index].picStr);
                    _image = Image.memory(decodedPicture);
                    
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            child: _image,
                          ),
                          Text("Title: ${picsController.pics[index].title}"),
                          Text("Desc: ${picsController.pics[index].description}"),
                          Text("Lat: ${picsController.pics[index].lat}"),
                          Text("Long: ${picsController.pics[index].long}"),
                          IconButton(icon: Icon(Icons.delete), onPressed: () {
                            picsController.remove(index).then((value) {
                              select();
                            });
                          })
                        ],
                      ),
                    );
                  },
                  itemCount: picsController.pics.length,
                ),
              ),
            ],
          ) : Center(
            child: Icon(
              Icons.hourglass_empty,
              size: 35,
            ),
          ),
        ),
      floatingActionButton: !_loading ? FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          getImage();
        },
        backgroundColor: brightness == Brightness.dark ? Colors.amber[600] : Colors.indigo[600],
      ) : null,
    );
  }

  Widget showAppBar(ThemeController themeController, Brightness brightness) {
    return !_loading ? 
    AppBar(
      backgroundColor: brightness == Brightness.dark ? Colors.grey[850] : Colors.white54,
      shadowColor: brightness == Brightness.dark ? Colors.grey[800] : Colors.black26,
      toolbarHeight: 70,
      centerTitle: true,
      title: InkWell(
        child: Image.asset(
          "icon.png",
          width: 50,
          height: 50
        ),
        // onTap: () {
        //   DateTime now = DateTime.now();
        //   String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);

        //   print(formattedDate);
        // },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    Icons.lightbulb,
                    size: 35,
                  ),
                ),
                content: Text(
                  "Bem vindo ao Pics, sua mais nova galeria Flutter.",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              );
            }
          );
        },
      ),
      leading: brightness == Brightness.dark ?
        IconButton(
          onPressed: () {
            themeController.changeBrightness();
          },
          icon: Icon(
            Icons.wb_sunny_rounded,
            color: Colors.amber[600],  
            size: 35
          ),
        ) : Center(),
      actions: [
        brightness == Brightness.light ? 
        IconButton(
          onPressed: () {
            themeController.changeBrightness();
          },
          icon: Icon(
            Icons.nights_stay_outlined,
            color: Colors.indigo[600],  
            size: 35,
          ),
        ) : Center()
      ],
      
    ) : PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: Text(""),
    );
  }

  Future<void> getImage() async {
    final pickedPicture = await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedPicture != null) {
      final bytes = await pickedPicture.readAsBytes();

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return AddPage(pictureString: base64Encode(bytes));
      })).then((value) {
        select();
      });
    } else {
      print("The user did not select a picture.");
    }
  }
}