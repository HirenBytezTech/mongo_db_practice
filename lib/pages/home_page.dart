import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_db_practice/model/mongo_model.dart';
import 'package:mongo_db_practice/mongo_query/mongo_db.dart';
import 'package:mongo_db_practice/pages/view_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.data});

  MongoData? data;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String buttonName = "Insert Data";

  editDataInitialize () {
    firstnameController.text = widget.data!.firstname;
    lastnameController.text = widget.data!.lastname;
    emailController.text = widget.data!.email;
    numberController.text = widget.data!.phone;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data != null){
      buttonName = "Update data";
      editDataInitialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
          child: Column(children: [
        TextField(controller: firstnameController),
        TextField(controller: lastnameController),
        TextField(controller: emailController),
        TextField(controller: numberController),
        ElevatedButton(
            onPressed: () async {
              if(widget.data != null){
                await updateData();
                Navigator.pop(context);
              } else {
                insertData();
              }
            },
            child: widget.data != null ?  const Text("Update Data")  :  const Text("Insert Data")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewData(),
                  ));
            },
            child: const Text("View Data")),
      ])),
    );
  }

  updateData () async {
    final data = MongoData(
        id: widget.data!.id,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        email: emailController.text,
        phone: numberController.text);
    await MongoDatabase.updateData(data);
  }

  insertData() async {
    final data = MongoData(
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        email: emailController.text,
        phone: numberController.text);
    final result = await MongoDatabase.insertMongo(data);
    print("object ==> $result");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Inserted ID ")));
  }
}
