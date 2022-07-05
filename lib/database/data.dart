import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fal_hafez/models/single_fal.dart';

class Data{


  Future<Database> initDb() async{
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'hafez.db');

    final exists = await databaseExists(path);

    if(exists){
      await openDatabase(path);

    }else{
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}

      ByteData data = await rootBundle.load(join("database", "hafez.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      await File(path).writeAsBytes(bytes,flush: true);
    }
    return await openDatabase(path);

  }

  Future<Fal> randomItem() async{
    Database db = await initDb();
    var r = Random();
    var rnd = r.nextInt(100);
    final List<Map<String, dynamic>> maps = await db.query('hafez');
    Fal result = Fal(
        maps[rnd]['matn'],
        maps[rnd]['poem']
    );
    return result;
  }

}