import 'package:digital_business_cards/database/CardModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:uuid/uuid.dart';

/**
 * Code from Flutter Documentation, available here: https://docs.flutter.dev/cookbook/persistence/sqlite
 */
class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'digital_business_cards.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cards(id TEXT PRIMARY KEY, '
              'name TEXT, '
              'job TEXT, '
              'web TEXT,'
              'email TEXT,'
              'telephone TEXT,'
              'mobile TEXT,'
              'address TEXT,'
              'photoUrl TEXT,'
              'logoUrl TEXT,'
              'userCard INTEGER DEFAULT 0)',
        );
      },
    );
  }

  static Future<int> insertUserData(CardModel card) async {
    final db = await database();

    List<Map<String, dynamic>> userCardAlreadyDefined = await getUserCard();

    // if userCard already defined
    if (userCardAlreadyDefined.isNotEmpty) {
      return await updateUserCard(card);
    }

    int result = await db.insert(
      'cards',
      {
        'id': Uuid().v1(), // time dependend id
        'name': card.name,
        'job': card.job,
        'web': card.web,
        'email': card.email,
        'telephone': card.telephone,
        'mobile': card.mobile,
        'address': card.address,
        'photoUrl': card.photoUrl,
        'logoUrl': card.logoUrl,
        'userCard': card.userCard,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Notify the stream controller about the change
    _dataStreamController.add(await getData());

    return result;
  }

  static Future<int> insertData(CardModel card) async {
    final db = await database();
    List<Map<String, dynamic>> userCardAlreadyDefined = await getCard(card.id);
    // if userCard already defined
    if (userCardAlreadyDefined.isNotEmpty) {
      return await updateCard(card);
    }

    int result = await db.insert(
      'cards',
      {
        'id': card.id,
        'name': card.name,
        'job': card.job,
        'web': card.web,
        'email': card.email,
        'telephone': card.telephone,
        'mobile': card.mobile,
        'address': card.address,
        'photoUrl': card.photoUrl,
        'logoUrl': card.logoUrl,
        'userCard': card.userCard,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Notify the stream controller about the change
    _dataStreamController.add(await getData());

    return result;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await database();
    return await db.query('cards');
  }

  static Future<List<Map<String, dynamic>>> getUserCard() async {
    final db = await database();
    return await db.rawQuery('SELECT * FROM cards WHERE userCard = 1');
  }

  static Future<List<Map<String, dynamic>>> getCard(String id) async {
    final db = await database();
    return await db.rawQuery('SELECT * FROM cards WHERE id="$id"');
  }

  static Future<int> updateUserCard(CardModel card) async {
    final db = await database();
    int result = await db.update(
      'cards',
      {
        'id': card.id,
        'name': card.name,
        'job': card.job,
        'web': card.web,
        'email': card.email,
        'telephone': card.telephone,
        'mobile': card.mobile,
        'address': card.address,
        'photoUrl': card.photoUrl,
        'logoUrl': card.logoUrl,
        'userCard': card.userCard,
      },
      where: 'userCard = 1',
    );
    _dataStreamController.add(await getData());
    return result;
  }

  static Future<int> updateCard(CardModel card) async {
    final db = await database();
    int result = await db.update(
      'cards',
      {
        'id': card.id,
        'name': card.name,
        'job': card.job,
        'web': card.web,
        'email': card.email,
        'telephone': card.telephone,
        'mobile': card.mobile,
        'address': card.address,
        'photoUrl': card.photoUrl,
        'logoUrl': card.logoUrl,
        'userCard': card.userCard,
      },
      where: 'id = "${card.id}"',
    );
    _dataStreamController.add(await getData());
    return result;
  }

  static StreamController<List<Map<String, dynamic>>> _dataStreamController =
  StreamController<List<Map<String, dynamic>>>.broadcast();

  static Stream<List<Map<String, dynamic>>> get dataStream =>
      _dataStreamController.stream;

}