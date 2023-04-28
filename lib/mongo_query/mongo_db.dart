import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_practice/utils/constants.dart';

import '../model/mongo_model.dart';

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

  /// Insert into database
  static Future<String> insertMongo (MongoData data) async {
    try{
      var result = await userCollection.insertOne(data.toJson());
      if(result.isSuccess){
        return "succefull";
      }else{
        return "unsuccefull";
      }
    }catch (e){
      return e.toString();
    }
  }
}