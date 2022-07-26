import 'package:flutter/material.dart';

import 'db/cashed_users.dart';
import 'db/local_database.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CachedUser> cachedUsers = [];

  Future<void> _init() async {
    cachedUsers = await LocalDatabase.getAllCachedUsers();
  }

  @override
  void initState() {
   _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sql User table"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              var userItem = CachedUser(age: 18, userName: "shermat qozi");
              await LocalDatabase.insertCachedUser(userItem);
              cachedUsers = await LocalDatabase.getAllCachedUsers();
              setState(() {});
            },
            child: Text("Run Action"),
          ),
          Expanded(
              child: ListView(
                  children: List.generate(cachedUsers.length, (index) {
            var currentUserItem = cachedUsers[index];
            return ListTile(
              title: Text(currentUserItem.userName),
              subtitle: Text(currentUserItem.age.toString()),
              trailing: Text(currentUserItem.id.toString()),
            );
          }))),
        ],
      ),
    );
  }
}
