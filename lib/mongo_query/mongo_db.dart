import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_practice/utils/constants.dart';

class MongoDatabase {

  static var db, userCollection;


  /// Create database
  static connectMongo () async {
    db = await Db.create(mongoDbUrl);
    await db.open();
    inspect(db);
    userCollection = db.collection(mongoCollectionName);
    print("object = > ${userCollection}");
  }
}