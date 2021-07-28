import 'package:flutter_pics/config/database.dart';
import 'package:flutter_pics/models/pic.dart';

class PicsRepository {
  String sqlInsert = "INSERT INTO pics (string ,title, description, lat, long, date) VALUES (?,?,?,?,?,?)";
  String sqlDelete = "DELETE FROM pics WHERE id = ?";

  Future<List<Pic>> selectAll() async {
    BancoDeDados bancoDeDados = BancoDeDados();

    await bancoDeDados.openDb().then((value) {});
    
    return await bancoDeDados.db
      .rawQuery("SELECT * FROM pics")
      .then((List<Map<String, dynamic>> fromDb) {
        List<Pic> pics = [];

        fromDb.forEach((Map<String, dynamic> element) {    
          Pic pic = Pic.fromMap(element);
          pics.add(pic);
        });

        return pics;
      });
  }

  Future<int> insert(Pic pic) async {
    BancoDeDados bancoDeDados = BancoDeDados();

    await bancoDeDados.openDb().then((value) {});

    return await bancoDeDados.db
      .rawInsert(sqlInsert, [pic.picStr, pic.title, pic.description, pic.lat, pic.long, pic.date]);
  }

  Future<int> delete(Pic pic) async {
    BancoDeDados bancoDeDados = BancoDeDados();

    await bancoDeDados.openDb().then((value) {});

    await bancoDeDados.db
      .rawDelete(sqlDelete, [pic.id]);
  }
}