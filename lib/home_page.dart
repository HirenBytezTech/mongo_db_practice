import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_db_practice/model/mongo_model.dart';
import 'package:mongo_db_practice/mongo_query/mongo_db.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(child: Column(children: [
        TextField(controller: firstnameController),
        TextField(controller: lastnameController),
        TextField(controller: emailController),
        TextField(controller: numberController),
        ElevatedButton(onPressed: () {
          insterData();
        }, child: Text("Insert Data"))
      ])),
    );
  }
  insterData () async {
    var id = M.ObjectId;
    final data = MongoData(id: "$id", firstname: firstnameController.text, lastname: lastnameController.text, email: emailController.text, phone: numberController.text);
    print("data == > ${data.firstname}");
    final result = await MongoDatabase.insertMongo(data);
    print("object ==> $result");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID $id")));
  }
}
