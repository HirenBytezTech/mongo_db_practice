import 'package:flutter/material.dart';
import 'package:mongo_db_practice/mongo_query/mongo_db.dart';

import '../model/mongo_model.dart';
import 'home_page.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var lengthData = snapshot.data!.length;
                return ListView.builder(
                  itemCount: lengthData,
                  itemBuilder: (context, index) {
                    return displayCard(
                        MongoData.fromJson(snapshot.data![index]),context);
                  },
                );
              } else {
                return const Center(
                  child: Text("No Data Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayCard(MongoData data,context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(flex: 4,
          child: Column(
            children: [
              Text(data.id.toString()),
              Text(data.firstname),
              Text(data.lastname),
              Text(data.email, style: const TextStyle(color: Colors.red)),
              Text(
                data.phone,
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () {
                Navigator
                    .push(context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(data: data),
                    )).whenComplete(() => setState(() {}));
                },
              icon: const Icon(Icons.edit)),
        ),
        Expanded(
          child: IconButton(
              onPressed: () async {
                await MongoDatabase.deleteData(data);
                setState(() {});
              },
              icon: const Icon(Icons.delete)),
        ),
      ]),
    );
  }
}
