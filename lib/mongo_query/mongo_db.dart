import 'dart:developer';
import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_practice/utils/constants.dart';

import '../model/mongo_model.dart';

class MongoDatabase {
  static var db, userCollection;

  /// Create database
  static connectMongo() async {
    db = await Db.create(mongoDbUrl);
    await db.open();
    inspect(db);
    userCollection = db.collection(mongoCollectionName);
    print("object = > ${userCollection}");
  }

  /// Insert into database
  static Future<String> insertMongo(MongoData data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "successful";
      } else {
        return "unsuccessful";
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// View / display data
  static Future<List<Map<String, dynamic>>> getData() async {
    final getAllData = await userCollection.find().toList();
    return getAllData;
  }

  /// Update data
  static Future<void> updateData(MongoData data) async {
    var response = await userCollection.update(await userCollection.findOne(where.id(data.id!)),{
        // "_id" : data.id,
        "firstname": data.firstname,
        "lastname": data.lastname,
        "email": data.email,
        "phone": data.phone,
      });
      print("response ==> ${response.toString()}");
      // inspect(response);
      // await db.close();
  }

  /// delete data
  static deleteData(MongoData data) async {
    await userCollection.remove(where.id(data.id!));
  }
}
