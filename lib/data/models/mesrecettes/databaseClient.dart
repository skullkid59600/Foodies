import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'article.dart';

class DatabaseClient {

   Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      print('Je suis null');
      //Créer cette database
      _database = await create();
      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path, 'database.db');
    var bdd = await openDatabase(database_directory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE article (
     id INTEGER PRIMARY KEY,
     nom TEXT NOT NULL,
     ingredients TEXT NOT NULL,
     desc TEXT NOT NULL,
     image TEXT )
     '''
    );
  }


  Future<Article> upsertArticle(Article article) async {
    Database? maDatabase = await database;
    (article.id == null)
        ? article.id = await maDatabase?.insert('article', article.toMap())
        : await maDatabase?.update('article', article.toMap(), where: 'id = ?', whereArgs: [article.id]);
    return article;
  }

  Future<int?> delete(int id, String table) async {
    Database? maDatabase = await database;
    await maDatabase?.delete('article', where: 'item = ?', whereArgs: [id]);
    return await maDatabase?.delete(table, where: 'id = ?', whereArgs: [id]);
  }


  Future<List<Article>> allArticles() async {
    Database? maDatabase = await database;
    List<Map<String, dynamic>>? resultat = await maDatabase?.rawQuery('SELECT * FROM article');
    List<Article> articles = [];
    resultat?.forEach((map) {
      Article article = new Article();
      article.fromMap(map);
      articles.add(article);
    });
    return articles;
  }

}
